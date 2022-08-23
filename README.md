# Terraform Cloud Workspace: `repositories`

This directory manages the lifecycle of the [workloads](https://github.com/workloads/) GitHub Organization.

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| github_owner | This is the target GitHub organization or individual user account to manage. | `string` | yes |
| github_token | A GitHub OAuth / Personal Access Token. | `string` | yes |
| organization_members | User Names of GitHub Organization Members. | `list(string)` | no |
| organization_owners | User Names of GitHub Organization Owners. | `list(string)` | no |
| repositories | List of GitHub Repositories. | <pre>list(object({<br>    name                   = string<br>    description            = string<br>    homepage_url           = string<br>    visibility             = string<br>    topics                 = list(string)<br>    has_issues             = bool # TODO: mark as optional when 1.3.0 is out<br>    has_wiki               = bool # TODO: mark as optional when 1.3.0 is out<br>    allow_merge_commit     = bool<br>    allow_rebase_merge     = bool<br>    delete_branch_on_merge = bool<br>  }))</pre> | no |

### Outputs

| Name | Description |
|------|-------------|
| github_urls | GitHub URLs. |
<!-- END_TF_DOCS -->
