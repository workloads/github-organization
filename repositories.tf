module "special_repositories" {
  # see https://www.terraform.io/docs/language/meta-arguments/for_each.html
  for_each = {
    for repository in var.special_repositories :
    repository.name => repository
  }

  # TODO: update to new slug when 4.0.x has been released
  source = "git@github.com:operatehappy/terraform-github-repository.git?ref=updates-and-upgrades"

  name         = each.value.name
  description  = each.value.description
  homepage_url = each.value.homepage_url
  visibility   = each.value.visibility
  topics       = each.value.topics

  has_issues             = each.value.has_issues
  allow_merge_commit     = each.value.allow_merge_commit
  allow_rebase_merge     = each.value.allow_rebase_merge
  delete_branch_on_merge = each.value.delete_branch_on_merge
}


module "repositories" {
  # see https://www.terraform.io/docs/language/meta-arguments/for_each.html
  for_each = {
    for repository in var.repositories :
    repository.name => repository
  }

  # TODO: update to new slug when 4.0.x has been released
  source = "git@github.com:operatehappy/terraform-github-repository.git?ref=updates-and-upgrades"

  name        = each.value.name
  description = each.value.description
  files        = local.repository_files
  homepage_url = each.value.homepage_url
  visibility   = each.value.visibility
  topics       = each.value.topics

  has_issues             = each.value.has_issues
  allow_merge_commit     = each.value.allow_merge_commit
  allow_rebase_merge     = each.value.allow_rebase_merge
  delete_branch_on_merge = each.value.delete_branch_on_merge
}
