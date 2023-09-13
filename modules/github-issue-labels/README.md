# Terraform Submodule for GitHub Issue Labels

> This module manages the lifecycle of GitHub Issue Labels.

## Table of Contents

<!-- TOC -->
* [Terraform Submodule for GitHub Issue Labels](#terraform-submodule-for-github-issue-labels)
  * [Table of Contents](#table-of-contents)
  * [Usage](#usage)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
  * [Notes](#notes)
<!-- TOC -->

## Usage

For an implementation example of this module, see [`issue_labels.tf`](../../issue_labels.tf).

<!-- BEGIN_TF_DOCS -->
### Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| issue_labels | List of Issue Label Objects. | <pre>list(object({<br>    color       = string<br>    description = string<br>    name        = string<br>  }))</pre> | yes |
| repository | GitHub Repository for Issue Labels. | `string` | yes |

### Outputs

No outputs.
<!-- END_TF_DOCS -->

## Notes

* This module _may_ exhaust the rate limit of a GitHub API access token if the number of issue labels is large.
