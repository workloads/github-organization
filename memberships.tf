# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/membership
resource "github_membership" "organization" {
  for_each = toset(var.organization_owners)

  username = each.key
  role     = "admin"
}

# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/membership
resource "github_membership" "members" {
  for_each = toset(var.organization_members)

  username = each.key
  role     = "member"
}
