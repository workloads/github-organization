# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_security_manager
resource "github_organization_security_manager" "main" {
  team_slug = github_team.maintainers.slug
}
