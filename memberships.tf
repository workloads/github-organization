# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/membership
resource "github_membership" "organization" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = toset(var.organization_owners)

  username = each.key
  role     = "admin"
}

# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/membership
resource "github_membership" "members" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for member in var.organization_members :
    member.username => member
  }

  username = each.value.username
  role     = "member"
}
