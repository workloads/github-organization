# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_security_manager
resource "github_organization_security_manager" "main" {
  team_slug = github_team.maintainers.slug
}

locals {
  non_terraform_repositories = merge(
    module.repositories["container-images"],
    module.repositories["packer-templates"],
  )
}

# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection
resource "github_branch_protection" "main" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = merge(
    module.terraform_repositories,
  )

  repository_id = each.key
  pattern       = "main"

  # enforce status checks for administrators
  # enforce_admins = true

  # require all commits to be GPG-signed
  # require_signed_commits = true

  # prevent actors from pushing merge commits
  required_linear_history = true

  # require actors to address all conversations
  require_conversation_resolution = true

  # TODO required_status_checks
  # https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection#required_status_checks

  #  required_pull_request_reviews {
  #    # dismiss approved reviews when new commits are pushed
  #    dismiss_stale_reviews = true
  #
  #    restrict_dismissals = true
  #
  #    # only allow maintainers to dismiss pull request reviess
  #    # dismissal_restrictions = [
  #    #  "${var.github_owner}/${github_team.maintainers.slug}",
  #    # ]
  #
  #    # require_code_owner_reviews = true
  #
  #    # require at least one review approval
  #    # required_approving_review_count = 1
  #  }

  # only allow maintainers to push to `main`
  push_restrictions = [
    "${var.github_owner}/${github_team.maintainers.slug}"
  ]

  # disallow deletion of the `main` branch
  allows_deletions = false
}
