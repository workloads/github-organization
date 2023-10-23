# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team
resource "github_team" "maintainers" {
  name                      = "maintainers"
  description               = "Maintainers 🛠️"
  create_default_maintainer = false
  privacy                   = "closed"
}

# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_settings
resource "github_team_settings" "maintainers" {
  team_id = github_team.maintainers.id

  review_request_delegation {
    algorithm    = "LOAD_BALANCE"
    member_count = 1
    notify       = true
  }
}

# add all members of `var.organization_owners` to the `maintainers` team
# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership
resource "github_team_membership" "maintainers" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for member in github_membership.organization :
    member.username => member
  }

  team_id  = github_team.maintainers.id
  username = each.value.username
  role     = "maintainer"
}

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

# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team
resource "github_team" "reviewers" {
  name                      = "reviewers"
  description               = "Reviewers 🔎"
  create_default_maintainer = false
  privacy                   = "closed"
}

# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team
resource "github_team" "reviewers_children" {
  for_each = {
    for team in var.reviewer_teams :
    team.name_suffix => team
  }

  name                      = "${github_team.reviewers.name}/${each.value.name_suffix}"
  description               = "${each.value.description} Reviewers 🔎"
  create_default_maintainer = false
  parent_team_id            = github_team.reviewers.id
  privacy                   = each.value.privacy
}

# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_settings
resource "github_team_settings" "reviewers_children" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = github_team.reviewers_children

  team_id = each.value.id

  # see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_settings#github-review-request-delegation-configuration
  review_request_delegation {
    algorithm    = "LOAD_BALANCE"
    member_count = 1
    notify       = true
  }
}

# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership
resource "github_team_membership" "reviewers" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for member in github_membership.members :
    member.username => member
  }

  team_id  = github_team.maintainers.id
  username = each.value.username
  role     = "maintainer"
}
