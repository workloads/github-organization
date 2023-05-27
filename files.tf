locals {
  # see https://developer.hashicorp.com/terraform/language/functions/templatefile
  tooling_make_configs_github = templatefile("templates/scripts/config_github.tftpl.mk", {
    github_org = var.github_owner

    # flatten Terraform-based GitHub repository names to allow for consumption in Bash scripts
    github_repos = join(" ", [
      for repo in var.terraform_repositories : repo.name
    ])

    scorecard_checks = var.scorecard_checks
  })
}

# automatically update `workloads/assets/.gitattributes`
# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file
resource "github_repository_file" "tooling_gitattributes" {
  repository          = module.repositories["tooling"].github_repository.id
  branch              = "main"
  file                = ".gitattributes"
  content             = file("./templates/gitattributes/tooling.gitattributes")
  overwrite_on_create = true
}

# automatically update `workloads/assets/scripts/_config.sh` when new Terraform-based GitHub repositories are added
# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file
resource "github_repository_file" "tooling_make_configs_github" {
  repository          = module.repositories["tooling"].github_repository.id
  branch              = "main"
  file                = "make/configs/github.mk"
  content             = local.tooling_make_configs_github
  overwrite_on_create = true
}
