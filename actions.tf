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
resource "github_actions_organization_variable" "versions" {
  for_each = var.tool_versions_config

  variable_name = each.key
  visibility    = "all"
  value         = each.value.version
}
