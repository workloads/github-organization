# Terraform Cloud Workspace: `repositories`

> This directory manages the lifecycle of the GitHub Configuration for [@workloads](https://github.com/workloads).

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
| github_repository_slugs | GitHub repository slugs. |
| github_urls | GitHub URLs. |
| workspace_url | Terraform Cloud Workspace URL. |
<!-- END_TF_DOCS -->

## Author Information

This module is maintained by the contributors listed on [GitHub](https://github.com/workloads/github-organization/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
