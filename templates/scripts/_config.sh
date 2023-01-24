#!/bin/bash

# This is a Terraform-managed file; manual changes will be overwritten.
# see https://github.com/workloads/github-organization/blob/main/templates/scripts/_config.sh

# GitHub Organization Slug
# shellcheck disable=SC2034
GITHUB_ORG=${github_org}

# local directories (= GitHub Repositories) to consider
# shellcheck disable=SC2034
GITHUB_REPOSITORIES=(${github_repos})

