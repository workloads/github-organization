# enable when https://github.com/integrations/terraform-provider-github/issues/1336 is resolved
# see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_project
#resource "github_organization_project" "triage" {
#  name = "🚦 Triage"
#  body = "Organization-wide work that needs to be triaged."
#}

## see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/project_column
#resource "github_project_column" "triage_pending" {
#  project_id = github_organization_project.triage.id
#  name       = "🟡 Pending Triage"
#
#  depends_on = [
#    github_organization_project.triage
#  ]
#}
#
## see https://registry.terraform.io/providers/integrations/github/latest/docs/resources/project_column
#resource "github_project_column" "triage_rejected" {
#  project_id = github_organization_project.triage.id
#  name       = "🔴 Rejected"
#
#  depends_on = [
#    github_organization_project.triage
#  ]
#}
