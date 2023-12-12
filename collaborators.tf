# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborators
resource "github_repository_collaborators" "minecraft_bot" {
  # see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = toset(var.outside_collaborators["minecraft-bot"])

  repository = module.repositories["minecraft-bot"].github_repository.id

  user {
    permission = "maintain"
    username   = each.value
  }

  team {
    team_id = github_team.maintainers.id
  }
}
