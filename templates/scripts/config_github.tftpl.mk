# This is a Terraform-managed file; manual changes will be overwritten.
# see https://github.com/workloads/github-organization/blob/main/templates/scripts/config_github.tftpl.mk

# see https://docs.github.com/en/actions/learn-github-actions/contexts
GITHUB_ACTIONS_CONCLUSION = failure

# GitHub Organization Slug
GITHUB_ORG = ${github_org}

# local directories (= GitHub Repositories) to consider
GITHUB_REPOSITORIES = ${github_repos}

# OpenSSF Scorecard Checks to execute
SCORECARD_CHECKS = ${scorecard_checks}
