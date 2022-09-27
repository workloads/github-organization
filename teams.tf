# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team
resource "github_team" "contributors" {
  name                      = "contributors"
  description               = "Contributors ❤️"
  create_default_maintainer = false
  privacy                   = "closed"
}

# add all members of `var.github_organization_members` to the `contributors` team
# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership
resource "github_team_membership" "contributors" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for member in github_membership.members :
    member.username => member
  }

  team_id  = github_team.contributors.id
  username = each.value.username
  role     = "member"
}
