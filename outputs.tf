locals {
  base_url = "https://github.com"
  org_url  = "${local.base_url}/orgs/${var.github_owner}"
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
  ]
}
output "workspace_url" {
  description = "Terraform Cloud Workspace URL."
  value       = "https://app.terraform.io/app/${var.github_owner}/workspaces/repositories"
}
