# Terraform Cloud Workspace `repositories`

> This directory manages the lifecycle of the GitHub Configuration for [@workloads](https://github.com/workloads).

## Table of Contents

<!-- TOC -->
* [Terraform Cloud Workspace `repositories`](#terraform-cloud-workspace-repositories)
  * [Table of Contents](#table-of-contents)
  * [Usage](#usage)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
  * [Notes](#notes)
    * [API Rate Limits](#api-rate-limits)
  * [Author Information](#author-information)
  * [License](#license)
<!-- TOC -->

## Usage

This repository uses a standard Terraform workflow (`init`, `plan`, `apply`).

For more information, including detailed usage guidelines, see the [Terraform documentation](https://developer.hashicorp.com/terraform/cli/commands).

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| github_owner | This is the target GitHub organization or individual user account to manage. | `string` | yes |
| github_token | A GitHub OAuth / Personal Access Token. | `string` | yes |
| actions_config | Complex Object of GitHub Actions Configuration. | <pre>map(object({<br>    owner      = string<br>    repository = string<br><br>    # support GitHub Actions that share a repository and are stored in a sub-directory<br>    # value is optional and must be supplied without leading slash<br>    path = optional(string)<br><br>    version = string<br>  }))</pre> | no |
| github_organization_email | E-mail address to use for GitHub Organization. | `string` | no |
| organization_members | User Names of GitHub Organization Members. | `list(string)` | no |
| organization_owners | User Names of GitHub Organization Owners. | `list(string)` | no |
| repositories | List of GitHub Repositories. | <pre>list(object({<br>    name                   = string<br>    description            = string<br>    homepage_url           = string<br>    visibility             = string<br>    topics                 = list(string)<br>    has_issues             = bool # TODO: mark as optional<br>    has_wiki               = bool # TODO: mark as optional<br>    allow_merge_commit     = bool<br>    allow_rebase_merge     = bool<br>    delete_branch_on_merge = bool<br>  }))</pre> | no |
| scorecard_checks | OpenSSF Scorecard Checks. | `string` | no |
| special_repositories | List of non-Terraform-based GitHub Repositories. | <pre>list(object({<br>    name                   = string<br>    description            = string<br>    homepage_url           = string<br>    visibility             = string<br>    topics                 = list(string)<br>    has_issues             = bool # TODO: mark as optional when 1.3.0 is out<br>    has_wiki               = bool # TODO: mark as optional when 1.3.0 is out<br>    allow_merge_commit     = bool<br>    allow_rebase_merge     = bool<br>    delete_branch_on_merge = bool<br>  }))</pre> | no |
| terraform_repositories | List of GitHub Repositories. | <pre>list(object({<br>    name                   = string<br>    description            = string<br>    homepage_url           = string<br>    visibility             = string<br>    topics                 = list(string)<br>    has_issues             = optional(bool)<br>    has_wiki               = optional(bool)<br>    allow_merge_commit     = bool<br>    allow_rebase_merge     = bool<br>    delete_branch_on_merge = bool<br>  }))</pre> | no |

### Outputs

| Name | Description |
|------|-------------|
| github_actions_releases | GitHub Actions Releases. |
| github_repository_slugs | GitHub Repository slugs. |
| github_urls | GitHub URLs. |
| nomad_pack_registry_commands | Nomad Pack CLI Commands for Registry operations. |
| workspace_url | Terraform Cloud Workspace URL. |
<!-- END_TF_DOCS -->

## Notes

### API Rate Limits

GitHub API interactions for non-Enterprise accounts are [limited](https://docs.github.com/en/rest/rate-limit?apiVersion=2022-11-28) to _1000_ requests per hour per repository.

The large number of resources in the `@workloads/github-organization` repository may result in rate exhaustion when `plan` and `apply` runs are carried out repeatedly and in short succession.

## Author Information

This repository is maintained by the contributors listed on [GitHub](https://github.com/workloads/github-organization/graphs/contributors).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
