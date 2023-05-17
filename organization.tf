# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_settings
resource "github_organization_settings" "main" {
  # GitHub Organization settings:
  billing_email    = var.github_organization_email
  blog             = "https://workloads.io/"
  company          = "workloads.io"
  description      = "Multi-Cloud, Multi-Content Job Orchestration."
  email            = var.github_organization_email
  location         = "Netherlands"
  name             = "workloads.io"
  twitter_username = "wrklds"

  # GitHub Pages settings:
  members_can_create_pages         = false
  members_can_create_private_pages = false
  members_can_create_public_pages  = false

  # GitHub Projects settings:
  has_organization_projects = true
  has_repository_projects   = false

  # GitHub Repository settings:
  default_repository_permission            = "write"
  members_can_create_internal_repositories = false
  members_can_create_private_repositories  = true
  members_can_create_public_repositories   = false
  members_can_create_repositories          = true
  members_can_fork_private_repositories    = false

  # GitHub Security settings:
  advanced_security_enabled_for_new_repositories               = false
  dependabot_alerts_enabled_for_new_repositories               = true
  dependabot_security_updates_enabled_for_new_repositories     = true
  dependency_graph_enabled_for_new_repositories                = true
  secret_scanning_enabled_for_new_repositories                 = true
  secret_scanning_push_protection_enabled_for_new_repositories = false
}
