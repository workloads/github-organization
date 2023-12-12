module "repositories" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for repository in var.repositories :
    repository.name => repository
  }

  # see https://registry.terraform.io/modules/ksatirli/repository/github/4.1.0
  source  = "ksatirli/repository/github"
  version = "4.1.0"

  name         = each.value.name
  description  = each.value.description
  files        = local.repository_files
  homepage_url = each.value.homepage_url
  visibility   = each.value.visibility
  topics       = each.value.topics

  has_issues             = each.value.has_issues
  allow_merge_commit     = each.value.allow_merge_commit
  allow_rebase_merge     = each.value.allow_rebase_merge
  delete_branch_on_merge = each.value.delete_branch_on_merge

  team_repository_teams = [{
    team_id    = github_team.maintainers.id
    permission = "admin"
    }, {
    team_id    = github_team.contributors.id
    permission = "pull"
  }]
}

module "terraform_repositories" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for repository in var.terraform_repositories :
    repository.name => repository
  }

  # see https://registry.terraform.io/modules/ksatirli/repository/github/4.1.0
  source  = "ksatirli/repository/github"
  version = "4.1.0"

  name         = each.value.name
  description  = each.value.description
  files        = local.terraform_repository_files
  homepage_url = each.value.homepage_url
  visibility   = each.value.visibility
  topics       = each.value.topics

  has_issues             = each.value.has_issues
  allow_merge_commit     = each.value.allow_merge_commit
  allow_rebase_merge     = each.value.allow_rebase_merge
  delete_branch_on_merge = each.value.delete_branch_on_merge

  team_repository_teams = [{
    team_id    = github_team.maintainers.id
    permission = "admin"
    }, {
    team_id    = github_team.contributors.id
    permission = "push"
  }]
}
