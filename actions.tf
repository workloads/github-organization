# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable
resource "github_actions_variable" "enable_workflows" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = merge(
    module.repositories,
    module.terraform_repositories
  )

  repository    = each.key
  variable_name = "ENABLE_WORKFLOWS"
  value         = "true"
}

# set Hugo version as GitHub Organization Variable to allow
# for easier re-use and maintainability across GitHub Actions Workflows
# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_variable
resource "github_actions_organization_variable" "hugo_version" {
  variable_name = "hugo_version"
  visibility    = "all"
  value         = var.hugo_version
}

# get GitHub Release Tag Identifiers by polling the Releases Data Source:
# see https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/release
data "github_release" "actions" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    # URL may contain special characters and don't make user-friendly identifiers for Terraform State operations
    # so replace parts and then append the version to make the resulting string much clearer and user-friendly.
    # see https://developer.hashicorp.com/terraform/language/functions/replace
    for identifier, action in var.actions_config : identifier => action
  }

  repository  = each.value.repository
  owner       = each.value.owner
  retrieve_by = "tag"
  release_tag = each.value.version
}

# get GitHub Commitish by polling the Ref data source with the GitHub Release Tag Name
# see https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/ref
data "github_ref" "actions" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = data.github_release.actions

  repository = each.value.repository
  owner      = each.value.owner

  # TODO: make `ref` more dynamic
  ref = "tags/${each.value.release_tag}"
}

locals {
  # enhance locally available GitHub Actions configuration with data retrieved from the GitHub Releases and Ref data sources
  actions_config = {
    # This place is not a place of honor...
    # no highly esteemed deed is commemorated here...
    # (but we needed these values)
    for action in tolist(keys(var.actions_config)) : action => {
      owner      = var.actions_config[action].owner
      path       = var.actions_config[action].path
      ref        = data.github_ref.actions[action].ref
      repository = var.actions_config[action].repository
      sha        = data.github_ref.actions[action].sha
      version    = var.actions_config[action].version
    }
  }
}

# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_permissions
resource "github_actions_organization_permissions" "main" {
  # use a permissions policy that only allows selected GHAs to run
  allowed_actions = "selected"

  # require all repositories to abide by this policy
  enabled_repositories = "all"

  allowed_actions_config {
    # allow GitHub owned GHA to be used
    github_owned_allowed = false

    # allow verified GitHub Marketplace Actions to be run
    verified_allowed = false

    # define patterns for allowed GitHub Actions
    patterns_allowed = [
      for action in local.actions_config :
      # if `action.path` is set, adjust syntax for Action to include path, else default to global syntax
      action.path != null ? "${action.owner}/${action.repository}/${action.path}@${action.sha}" : "${action.owner}/${action.repository}@${action.sha}"
    ]
  }
}
