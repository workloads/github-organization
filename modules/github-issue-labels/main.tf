# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label
resource "github_issue_label" "main" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for label in var.issue_labels : label.name => label
  }

  repository  = var.repository
  color       = each.value.color
  description = each.value.description
  name        = each.value.name
}
