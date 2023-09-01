variable "github_owner" {
  type        = string
  description = "This is the target GitHub organization or individual user account to manage."
}

variable "github_organization_email" {
  type        = string
  description = "E-mail address to use for GitHub Organization."
  default     = "team@workloads.io"
}

variable "github_token" {
  type        = string
  description = "A GitHub OAuth / Personal Access Token."
  sensitive   = true
}

variable "actions_config" {
  type = map(object({
    owner      = string
    repository = string

    # support GitHub Actions that share a repository and are stored in a sub-directory
    # value is optional and must be supplied without leading slash
    path = optional(string)

    version = string
  }))

  description = "Complex Object of GitHub Actions Configuration."

  default = {
    # see https://github.com/reviewdog/action-actionlint/releases
    actionlint = {
      owner      = "reviewdog"
      repository = "action-actionlint"
      version    = "v1.37.1"
    }

    # see https://github.com/actions/checkout/releases
    checkout = {
      owner      = "actions"
      repository = "checkout"
      version    = "v3.6.0"
    }

    # see https://github.com/actions/upload-artifact/releases
    upload_artifact = {
      owner      = "actions"
      repository = "upload-artifact"
      version    = "v3.1.2"
    }

    # see https://github.com/github/codeql-action/releases
    codeql_upload = {
      owner      = "github"
      repository = "codeql-action"
      path       = "upload-sarif"
      version    = "codeql-bundle-v2.14.3"
    }

    # see https://github.com/gaurav-nelson/github-action-markdown-link-check/releases
    markdown = {
      owner      = "gaurav-nelson"
      repository = "github-action-markdown-link-check"
      version    = "1.0.15"
    }

    # see # https://github.com/snyk/actions/releases
    snyk_iac = {
      owner      = "snyk"
      repository = "actions"
      path       = "iac"
      version    = "0.4.0"
    }

    # see https://github.com/hashicorp/setup-packer/releases
    packer = {
      owner      = "hashicorp"
      repository = "setup-packer"
      version    = "v2.0.0"
    }

    # see https://github.com/ossf/scorecard-action/releases
    scorecard = {
      owner      = "ossf"
      repository = "scorecard-action"
      version    = "v2.2.0"
    }

    # see https://github.com/super-linter/super-linter/releases
    superlinter = {
      owner      = "super-linter"
      repository = "super-linter"
      path       = "slim"
      version    = "v5.2.1"
    }

    # see https://github.com/hashicorp/setup-terraform/releases
    terraform = {
      owner      = "hashicorp"
      repository = "setup-terraform"
      version    = "v2.0.3"
    }

    # see https://github.com/terraform-docs/gh-actions/releases
    terraform_docs = {
      owner      = "terraform-docs"
      repository = "gh-actions"
      version    = "v1.0.0"
    }
  }
}

variable "organization_owners" {
  type        = list(string)
  description = "User Names of GitHub Organization Owners."

  default = [
    "ksatirli",      # Kerim Satirli
    "workloads-bot", # service account
  ]
}

variable "organization_members" {
  type        = list(string)
  description = "User Names of GitHub Organization Members."

  default = [
    #"davemay99",     # Dave May (HashiCorp)
    "DerekStrickland", # Derek Strickland (Aquia)
    "drewmullen",      # Drew Mullen (AWS)
    "ericreeves",      # Eric Reeves (HashiCorp)
    "devopswithcobra", # Greg Thomas (HashiCorp)
    "im2nguyen",       # Tu Nguyen (HashiCorp)
    "joatmon08",       # Rosemary Wang (HashiCorp)
    "justinretzolk",   # Justin Retzolk (HashiCorp)
    "lhaig",           # Lance Haig (HashiCorp)
    "lomar92",         # Amar Lojo (HashiCorp)
    "sofixa",          # Adrian Todorov (HashiCorp)
    "straubt1",        # Tom Straub (HashiCorp)
    "rizkybiz",        # Justin DeFrank (HashiCorp)
  ]
}

variable "repositories" {
  type = list(object({
    name                   = string
    description            = string
    homepage_url           = string
    visibility             = string
    topics                 = list(string)
    has_issues             = bool # TODO: mark as optional
    has_wiki               = bool # TODO: mark as optional
    allow_merge_commit     = bool
    allow_rebase_merge     = bool
    delete_branch_on_merge = bool
  }))

  description = "List of GitHub Repositories."

  default = [
    {
      name         = ".github"
      description  = "Community Health Files and Assets"
      homepage_url = "https://github.com/workloads"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "github",
      ]

      allow_merge_commit     = true
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "assets"
      description  = "🔒 (non-public) Design and Content Assets"
      homepage_url = "https://github.com/workloads"
      visibility   = "private"
      has_issues   = true
      has_wiki     = false

      topics = []

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "container-images"
      description  = "Packer Templates for commonly used Container Images"
      homepage_url = "https://github.com/orgs/workloads/packages?repo_name=container-images"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "docker",
        "packer",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "edge-case"
      description  = "Docs and Diagrams for the Edge Case"
      homepage_url = "https://github.com/workloads/edge-case"
      visibility   = "private"
      has_issues   = true
      has_wiki     = false

      topics = [
        "cyberdeck",
        "raspberry-pi",
        "seeedstudio",
        "turing-pi",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "edge-case-docs"
      description  = "🔒 (non-public) Docs for the Edge Case"
      homepage_url = "https://github.com/workloads/edge-case"
      visibility   = "private"
      has_issues   = false
      has_wiki     = false

      topics = [
        "cyberdeck",
        "raspberry-pi",
        "seeedstudio",
        "turing-pi",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "nomad-pack-registry"
      description  = "Nomad Pack Registry"
      homepage_url = "https://github.com/workloads/nomad-pack-registry"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "nomad",
        "nomad-packs"
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "packer-templates"
      description  = "Packer Templates for commonly used Providers"
      homepage_url = "https://app.terraform.io/app/workloads/workspaces/packer-images"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "aws",
        "azure",
        "digital-ocean",
        "google-cloud",
        "packer",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "tooling"
      description  = "Common Tooling for @workloads Projects"
      homepage_url = "https://github.com/workloads/tooling"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "makefile",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
  ]
}

variable "terraform_repositories" {
  type = list(object({
    name                   = string
    description            = string
    homepage_url           = string
    visibility             = string
    topics                 = list(string)
    has_issues             = optional(bool)
    has_wiki               = optional(bool)
    allow_merge_commit     = bool
    allow_rebase_merge     = bool
    delete_branch_on_merge = bool
  }))

  description = "List of GitHub Repositories."

  default = [
    {
      name         = "community"
      description  = "Terraform-managed Community Resources"
      homepage_url = "https://app.terraform.io/app/workloads/workspaces/community"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "discord",
        "terraform",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "dns"
      description  = "Terraform-managed DNS Resources"
      homepage_url = "https://app.terraform.io/app/workloads/workspaces/dns"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "aws",
        "gandi",
        "terraform",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "github-organization"
      description  = "Terraform-managed GitHub Resources"
      homepage_url = "https://app.terraform.io/app/workloads/workspaces/repositories"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "1password-cli",
        "github",
        "terraform",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "networking"
      description  = "Terraform-managed Networking Components"
      homepage_url = "https://app.terraform.io/app/workloads/workspaces/networking"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "aws",
        "terraform",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "regional-aws-deployment"
      description  = "Regional Deployment of AWS-specific Resources"
      homepage_url = "https://go.workloads.io/aws-regional"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "aws",
        "terraform",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "regional-azure-deployment"
      description  = "Regional Deployment of Azure-specific Resources"
      homepage_url = "https://go.workloads.io/azure-regional"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "azure",
        "terraform",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "regional-gcp-deployment"
      description  = "Regional Deployment of GCP-specific Resources"
      homepage_url = "https://go.workloads.io/gcp-regional"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "gcp",
        "google-cloud",
        "terraform",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "regional-workspaces"
      description  = "Terraform-managed Regional Terraform Cloud Workspaces"
      homepage_url = "https://app.terraform.io/app/workloads/regional-workspaces"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "terraform",
        "aws",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "services-configuration"
      description  = "Terraform-managed Services Configuration"
      homepage_url = "https://app.terraform.io/app/workloads/workspaces/services-configuration"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "terraform",
        "vault",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "services-deployment"
      description  = "Terraform-managed Services Deployment"
      homepage_url = "https://app.terraform.io/app/workloads/workspaces/services-deployment"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "aws",
        "boundary",
        "consul",
        "hcp",
        "terraform",
        "vault",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "users"
      description  = "Terraform-managed User Directory Management"
      homepage_url = "https://app.terraform.io/app/workloads/workspaces/users"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "okta",
        "terraform",
        "vault"
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "web-assets"
      description  = "CloudFront-hosted Public Assets"
      homepage_url = "https://assets.workloads.io"
      visibility   = "public"
      has_issues   = false
      has_wiki     = false

      topics = [
        "aws",
        "terraform",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "web-redirects"
      description  = "URL Redirects."
      homepage_url = "https://go.workloads.io"
      visibility   = "public"
      has_issues   = false
      has_wiki     = false

      topics = [
        "aws",
        "terraform",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "website"
      description  = "Terraform-rendered, GitHub-infused Project Website"
      homepage_url = "https://workloads.io"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "aws",
        "html5",
        "terraform",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "workspaces"
      description  = "Terraform-managed Terraform Cloud Workspaces"
      homepage_url = "https://app.terraform.io/app/workloads/workspaces"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "terraform",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
  ]
}

variable "scorecard_checks" {
  type        = string
  description = "OpenSSF Scorecard Checks."

  # see https://github.com/ossf/scorecard/blob/main/docs/checks.md
  default = "Binary-Artifacts,Branch-Protection,Code-Review,Dangerous-Workflow,Dependency-Update-Tool,License,Maintained,Pinned-Dependencies,SAST,Security-Policy,Token-Permissions,Vulnerabilities"
}

locals {
  # list of files to manage for ALL GitHub Repositories.
  repository_files = [
    {
      file = ".github/workflows/markdown.yml",
      content = templatefile("./templates/workflows/markdown.tftpl.yml", {
        checkout = local.actions_config["checkout"]
        markdown = local.actions_config["markdown"]
      })

      overwrite_on_create = true
    },
    {
      file = ".github/workflows/superlinter.yml"
      content = templatefile("./templates/workflows/superlinter.tftpl.yml", {
        checkout    = local.actions_config["checkout"]
        superlinter = local.actions_config["superlinter"]
      })

      overwrite_on_create = true
    },
    {
      file                = ".markdown-link-check.json"
      content             = file("./templates/.markdown-link-check.json")
      overwrite_on_create = true
    },
    {
      file                = ".markdown-lint.yml"
      content             = file("./templates/.markdown-lint.yml")
      overwrite_on_create = true
    },
    {
      file                = ".yaml-lint.yml",
      content             = file("./templates/.yaml-lint.yml")
      overwrite_on_create = true
    },
    {
      file                = "LICENSE",
      content             = file("./templates/LICENSE")
      overwrite_on_create = true
    },
  ]

  # list of files to manage for Terraform-specific GitHub Repositories.
  terraform_repository_files = concat(local.repository_files, [
    {
      # see https://git-scm.com/docs/gitattributes
      file                = ".gitattributes"
      content             = file("./templates/gitattributes/terraform.gitattributes")
      overwrite_on_create = true
    },
    {
      file                = ".gitignore"
      content             = file("./templates/gitignores/terraform.gitignore")
      overwrite_on_create = true
    },
    {
      # see https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners#about-code-owners
      file = "CODEOWNERS"

      content = templatefile("./templates/codeowners.tftpl.yml", {
        codeowner = "@${var.github_owner}/${github_team.maintainers.slug}"
      })

      overwrite_on_create = true
    },
    {
      # see https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuration-options-for-the-dependabot.yml-file#about-the-dependabotyml-file
      file = ".github/dependabot.yml"

      content = templatefile("./templates/dependabot/terraform.tftpl.yml", {
        assignee = "${var.github_owner}/${github_team.maintainers.slug}"
      })

      overwrite_on_create = true
    },
    {
      file = ".github/workflows/snyk-iac.yml"
      content = templatefile("./templates/workflows/snyk-iac.tftpl.yml", {
        checkout      = local.actions_config["checkout"]
        codeql_upload = local.actions_config["codeql_upload"]
        snyk_iac      = local.actions_config["snyk_iac"]
      })

      overwrite_on_create = true
    },
    {
      file = ".github/workflows/terraform.yml"
      content = templatefile("./templates/workflows/terraform.tftpl.yml", {
        checkout  = local.actions_config["checkout"]
        terraform = local.actions_config["terraform"]
      })

      overwrite_on_create = true
    },
    {
      file = ".github/workflows/terraform-docs.yml"
      content = templatefile("./templates/workflows/terraform-docs.tftpl.yml", {
        checkout       = local.actions_config["checkout"]
        terraform_docs = local.actions_config["terraform_docs"]
      })

      overwrite_on_create = true
    },
    {
      # see https://terraform-docs.io/user-guide/configuration/
      file                = ".terraform-docs.yml"
      content             = file("./templates/.terraform-docs.yml")
      overwrite_on_create = true
    },
    {
      # see https://github.com/terraform-linters/tflint/blob/master/docs/user-guide/plugins.md
      file                = ".tflint.hcl"
      content             = file("./templates/.tflint.hcl")
      overwrite_on_create = true
    },
  ])
}
