# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_permissions
resource "github_actions_organization_permissions" "main" {
  # use a permissions policy that only allows selected GHAs to run
  allowed_actions = "selected"

  # require all repositories to abide by this policy
  enabled_repositories = "all"

  allowed_actions_config {
    # allow GitHub owned GHA to be used
    github_owned_allowed = true

    # allow verified GitHub Marketplace Actions to be run
    verified_allowed = true

    # define patterns for allowed GitHub Actions
    # TODO: find better way of expressing this
    patterns_allowed = [
      # see https://github.com/actions/checkout
      "${var.actions_config.checkout.owner}/${var.actions_config.checkout.repository}@${var.actions_config.checkout.version}",

      # see https://github.com/github/codeql-action
      "${var.actions_config.codeql_upload.owner}/${var.actions_config.codeql_upload.repository}@${var.actions_config.codeql_upload.version}",

      # see https://github.com/github/super-linter#slim-image
      "${var.actions_config.superlinter.owner}/${var.actions_config.superlinter.repository}@${var.actions_config.superlinter.version}",

      # allow specific HashiCorp Actions
      "${var.actions_config.terraform.owner}/${var.actions_config.terraform.repository}@${var.actions_config.terraform.version}",

      # see https://github.com/terraform-docs/gh-actions
      "${var.actions_config.terraform_docs.owner}/${var.actions_config.terraform_docs.repository}@${var.actions_config.terraform_docs.version}",

      # see https://github.com/gaurav-nelson/github-action-markdown-link-check
      "${var.actions_config.markdown.owner}/${var.actions_config.markdown.repository}@${var.actions_config.markdown.version}",
    ]
  }
}


# get SHA checksums for GitHub Action repositories by polling the Releases Data Source:
# see https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/release
data "github_release" "actions" {
  for_each = {
    for action in var.actions_config :

    # URL may contain special characters and don't make user-friendly identifiers for Terraform State operations
    # so replace parts and then append the version to make the resulting string much clearer and user-friendly.
    # see https://developer.hashicorp.com/terraform/language/functions/replace
    "${action.repository}-${action.version}" => action
  }

  repository  = each.value.repository
  owner       = each.value.owner
  retrieve_by = "tag"
  release_tag = each.value.version
}

# TODO: add `target_commitish` retrieval when https://github.com/integrations/terraform-provider-github/pull/1651 lands
