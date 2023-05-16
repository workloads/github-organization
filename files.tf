locals {
  # see https://developer.hashicorp.com/terraform/language/functions/templatefile
  assets_script_config = templatefile("templates/scripts/_config.mk", {
    github_org = var.github_owner

    # flatten Terraform-based GitHub repository names to allow for consumption in Bash scripts
    github_repos = join(" ", [
      for repo in var.terraform_repositories : repo.name
    ])
  })
}

# automatically update `workloads/assets/.gitattributes`
# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file
resource "github_repository_file" "assets_gitattributes" {
  repository          = module.special_repositories["assets"].github_repository.id
  branch              = "main"
  file                = ".gitattributes"
  content             = file("./templates/gitattributes/assets.gitattributes")
  overwrite_on_create = true
}

# automatically update `workloads/assets/scripts/_config.sh` when new Terraform-based GitHub repositories are added
# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file
resource "github_repository_file" "assets_scripts_config" {
  repository          = module.special_repositories["assets"].github_repository.id
  branch              = "main"
  file                = "scripts/_config.mk"
  content             = local.assets_script_config
  overwrite_on_create = true
}
