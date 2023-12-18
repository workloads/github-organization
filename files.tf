locals {
  # see https://developer.hashicorp.com/terraform/language/functions/templatefile
  tooling_make_configs_github = templatefile("templates/scripts/config_github.tftpl.mk", {
    github_org = var.github_owner

    # flatten GitHub Repository names to allow for consumption in downstream tooling (Make)
    github_repositories = join(" ", [
      for repo in var.repositories : repo.name
    ])

    github_terraform_repositories = join(" ", [
      for repo in var.terraform_repositories : repo.name
    ])

    scorecard_checks = var.scorecard_checks
  })
}
