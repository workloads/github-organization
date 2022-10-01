module "repositories" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for repository in var.repositories :
    repository.name => repository
  }

  # see https://registry.terraform.io/modules/ksatirli/repository/github/4.0.1
  source  = "ksatirli/repository/github"
  version = "4.0.1"

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
}

module "special_repositories" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for repository in var.special_repositories :
    repository.name => repository
  }

  # see https://registry.terraform.io/modules/ksatirli/repository/github/4.0.1
  source  = "ksatirli/repository/github"
  version = "4.0.1"

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

module "terraform_repositories" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = {
    for repository in var.terraform_repositories :
    repository.name => repository
  }

  # see https://registry.terraform.io/modules/ksatirli/repository/github/4.0.1
  source  = "ksatirli/repository/github"
  version = "4.0.1"

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
}
