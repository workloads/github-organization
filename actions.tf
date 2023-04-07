# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_permissions
resource "github_actions_organization_permissions" "main" {
  # use a permissions policy that only allows selected GHAs to run
  allowed_actions = "selected"

  # require all repositories to abide by this policy
  enabled_repositories = "all"

  allowed_actions_config {
    # allow GitHub owned GHA to be used
    github_owned_allowed = true

    # allow verified GitHub Marketplace Actions to be run
    verified_allowed = true

    # define patterns for allowed GitHub Actions
    patterns_allowed = [
      # see https://github.com/actions/checkout
      "${var.actions_config.checkout.url}@${var.actions_config.checkout.version}",

      # see https://github.com/github/codeql-action
      "${var.actions_config.codeql-upload.url}@${var.actions_config.codeql-upload.version}",

      # see https://github.com/github/super-linter#slim-image
      "${var.actions_config.superlinter.url}@${var.actions_config.superlinter.version}",

      # allow specific HashiCorp Actions
      "${var.actions_config.terraform.url}@${var.actions_config.terraform.version}",

      # see https://github.com/terraform-docs/gh-actions
      "${var.actions_config.terraform-docs.url}@${var.actions_config.terraform-docs.version}",

      # see https://github.com/gaurav-nelson/github-action-markdown-link-check
      "${var.actions_config.markdown.url}@${var.actions_config.markdown.version}",
    ]
  }
}
