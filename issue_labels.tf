# TODO: enable when https://github.com/integrations/terraform-provider-github/issues/1840 is fixed
## HashiCorp Product-specific Issue Labels are assigned to all Terraform repositories
## This can be solved by either using a nested `for_each`, or by modularizing the code
#module "hashicorp_issue_labels" {
#  source = "./modules/github-issue-labels"
#
#  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
#  for_each = {
#    # iterate over the `name` property of the `github_repository` output of the
#    # GH Repository Module and assign `name` as the identifier for each iteration
#    for repository in module.terraform_repositories : repository.github_repository.name => {
#      repository = repository
#    }
#  }
#
#  issue_labels = var.issue_labels_hashicorp
#  repository   = each.value.repository.github_repository.name
#}
