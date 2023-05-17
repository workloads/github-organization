# This is a Terraform-managed file; manual changes will be overwritten.
# see https://github.com/workloads/github-organization/blob/main/templates/scripts/_config.mk

# GitHub Organization Slug
GITHUB_ORG = ${github_org}

# local directories (= GitHub Repositories) to consider
GITHUB_REPOSITORIES = ${github_repos}

# OpenSSF Scorecard Checks to execute
SCORECARD_CHECKS = ${scorecard_checks}
