locals {
  base_url                     = "https://github.com"
  pack_registry_repository_url = "github.com/${module.repositories["nomad-pack-registry"].github_repository.full_name}"
  org_url                      = "${local.base_url}/orgs/${var.github_owner}"

  github_repository_slugs = merge(
    module.repositories,
    module.terraform_repositories
  )
}

output "github_actions_organization_tool_versions" {
  description = "GitHub Actions Organization Tool Versions."

  # iterate over GitHub Actions Organization Variable Objects and assign `name` as value
  value = github_actions_organization_variable.versions
}

output "github_repository_slugs" {
  description = "GitHub Repository slugs."

  # iterate over Repository Objects and assign `full_name` as value
  value = {
    for identifier, repository in local.github_repository_slugs : identifier => repository.github_repository.full_name
  }
}

output "github_terraform_repository_slugs" {
  description = "GitHub Terraform Repository slugs."

  # iterate over Repository Objects and assign `full_name` as value
  value = {
    for identifier, repository in module.terraform_repositories : identifier => repository.github_repository.full_name
  }
}

output "github_urls" {
  description = "GitHub URLs."

  value = [
    "${local.base_url}/${var.github_owner}",
    local.org_url,
    "${local.org_url}/repositories",
    "${local.org_url}/teams",
    "${local.org_url}/people",
    "${local.org_url}/people/pending_invitations",
    "${local.org_url}/settings/profile",
    "${local.org_url}/settings/security_analysis",
    "${local.org_url}/settings/domains",
    "${local.org_url}/settings/secrets/actions",
  ]
}

output "nomad_pack_registry_commands" {
  description = "Nomad Pack CLI Commands for Registry operations."

  value = {
    add_registry = "nomad-pack registry add ${var.github_owner} ${local.pack_registry_repository_url}"
  }
}

output "tfe_workspace_terraform_version" {
  description = "Terraform version identifier of current HCP Terraform Workspace."
  value       = data.tfe_workspace.main.terraform_version
}

output "workspace_url" {
  description = "HCP Terraform Workspace URL."
  value       = "https://app.terraform.io/app/${var.github_owner}/workspaces/repositories"
}
