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
    "${local.org_url}/settings/profile",
  ]
}
