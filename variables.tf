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
      version    = "v1.46.0"
    }

    # see https://github.com/aws-actions/configure-aws-credentials/releases
    aws_credentials = {
      owner      = "aws-actions"
      repository = "configure-aws-credentials"
      version    = "v4.0.2"
    }

    # see https://github.com/actions/checkout/releases
    checkout = {
      owner      = "actions"
      repository = "checkout"
      version    = "v4.1.6"
    }

    # see https://github.com/github/codeql-action/releases
    codeql_upload = {
      owner      = "github"
      repository = "codeql-action"
      path       = "upload-sarif"
      version    = "codeql-bundle-v2.17.3"
    }

    # see https://github.com/peaceiris/actions-hugo/releases
    hugo = {
      owner      = "peaceiris"
      repository = "actions-hugo"
      version    = "v3.0.0"
    }

    # see https://github.com/hashicorp/setup-packer/releases
    packer = {
      owner      = "hashicorp"
      repository = "setup-packer"
      version    = "v3.1.0"
    }

    # see https://github.com/ossf/scorecard-action/releases
    scorecard = {
      owner      = "ossf"
      repository = "scorecard-action"
      version    = "v2.3.3"
    }

    # see # https://github.com/snyk/actions/releases
    snyk_iac = {
      owner      = "snyk"
      repository = "actions"
      path       = "iac"
      version    = "0.4.0"
    }

    # see https://github.com/super-linter/super-linter/releases
    superlinter = {
      owner      = "super-linter"
      repository = "super-linter"
      version    = "v6.5.1"
    }

    # see https://github.com/hashicorp/setup-terraform/releases
    terraform = {
      owner      = "hashicorp"
      repository = "setup-terraform"
      version    = "v3.1.1"
    }

    # see https://github.com/terraform-docs/gh-actions/releases
    terraform_docs = {
      owner      = "terraform-docs"
      repository = "gh-actions"
      version    = "v1.1.0"
    }

    # see https://github.com/actions/upload-artifact/releases
    upload_artifact = {
      owner      = "actions"
      repository = "upload-artifact"
      version    = "v4.3.3"
    }

    # see https://github.com/errata-ai/vale-action/releases
    vale = {
      owner      = "errata-ai"
      repository = "vale-action"
      version    = "v2.1.0"
    }
  }
}

variable "issue_labels_hashicorp" {
  type = list(object({
    color       = string
    description = optional(string)
    name        = string
  }))

  description = "HashiCorp Product-specific Issue Labels."

  default = [
    {
      color       = "EC585D"
      description = "Issues related to HashiCorp Boundary"
      name        = "boundary"
      }, {
      color       = "DC477D"
      description = "Issues related to HashiCorp Consul"
      name        = "consul"
      }, {
      color       = "000000"
      description = "Issues related to HashiCorp Cloud Platform"
      name        = "hashicorp-cloud-platform"
      }, {
      color       = "00CA8E"
      description = "Issues related to HashiCorp Nomad"
      name        = "nomad"
      }, {
      color       = "02A8EF"
      description = "Issues related to HashiCorp Packer"
      name        = "packer"
      }, {
      color       = "7B42BC"
      description = "Issues related to HashiCorp Terraform"
      name        = "terraform"
      }, {
      color       = "FFCF25"
      description = "Issues related to HashiCorp Vault"
      name        = "vault"
      }, {
      color       = "14C6CB"
      description = "Issues related to HashiCorp Waypoint"
      name        = "waypoint"
    }
  ]
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
  type = list(object({
    username = string
    teams    = list(string)
  }))

  description = "User Names and Team Associations of GitHub Organization Members."

  default = [
    {
      # Charlie Voiselle (HashiCorp)
      username : "angrycub",
      teams : [
        "nomad",
      ]
      }, {
      # Drew Mullen (River Point Technology)
      username : "drewmullen",
      teams : []
      }, {
      # Eric Reeves (HashiCorp)
      username : "ericreeves",
      teams : []
      }, {
      # Tu Nguyen (HashiCorp)
      username : "im2nguyen",
      teams : []
      }, {
      # Rosemary Wang (HashiCorp)
      username : "joatmon08",
      teams : []
      }, {
      # Justin Retzolk (HashiCorp)
      username : "justinretzolk",
      teams : [
        "terraform",
      ]
      }, {
      # Lance Haig (HashiCorp)
      username : "lhaig",
      teams : [
        "nomad",
      ]
      }, {
      # Justin DeFrank (HashiCorp)
      username : "rizkybiz",
      teams : [
        "terraform",
        "boundary",
      ]
      }, {
      # Adrian Todorov (HashiCorp)
      username : "sofixa",
      teams : [
        "terraform",
        "nomad",
      ]
      }, {
      # Tom Straub (HashiCorp)
      username : "straubt1",
      teams : [
        "terraform",
      ]
      }, {
      # Timothy Mamo (DigitalOcean)
      username : "timothymamo",
      teams : []
      }, {
      # Yash Khemani (HashiCorp)
      username : "ykhemani",
      teams : [
        "terraform",
        "vault",
      ]
    }
  ]
}

variable "outside_collaborators" {
  type        = map(list(string))
  description = "Map of Outside Collaborators."

  default = {
    "minecraft-bot" : [
    ]
  }
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
      name         = "baedge"
      description  = "B{ae}dge Computing Server"
      homepage_url = "https://github.com/workloads/baedge"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "eink",
        "nomad",
        "raspberry-pi",
        "seeedstudio",
        "waveshare",
      ]

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
      name         = "hugo-theme-workloads"
      description  = "Hugo Theme for @workloads Website"
      homepage_url = "https://workloads.io"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "hugo",
        "hugo-theme",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "mapper"
      description  = "Event Mapping Tool for HashiCorp Nomad"
      homepage_url = "https://github.com/workloads/mapper"
      visibility   = "private"
      has_issues   = true
      has_wiki     = false

      topics = [
        "eventstream",
        "nomad",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "minecraft-bot"
      description  = "Mineflayer-based Excavation Assistant"
      homepage_url = "https://github.com/workloads/minecraft-bot"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "minecraft",
        "minecraft-bot",
        "mineflayer",
        "mineflayer-bot",
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
        "nomad-packs",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "nomad-smart-dial"
      description  = "Smart Dial for HashiCorp Nomad"
      homepage_url = "https://github.com/workloads/nomad-smart-dial"
      visibility   = "private"
      has_issues   = true
      has_wiki     = false

      topics = [
        "arduino",
        "esp32",
        "m5stack",
        "m5dial",
        "nomad",
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
    {
      name         = "website"
      description  = "Hugo-powered Website"
      homepage_url = "https://workloads.io"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "aws",
        "hugo",
      ]

      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
  ]
}

variable "reviewer_teams" {
  type = list(object({
    name_suffix = string
    description = string
    privacy     = optional(string, "closed")
  }))

  description = "List of Reviewer Teams."

  default = [
    {
      name_suffix = "boundary"
      description = "Boundary"
    },
    {
      name_suffix = "nomad"
      description = "Nomad (incl. Nomad Packs)"
    },
    {
      name_suffix = "terraform"
      description = "Terraform (incl. Modules)"
    },
    {
      name_suffix = "vault"
      description = "Vault (incl. HCP Vault Secrets)"
    }
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
      description  = "Terraform-managed DNS resources"
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
      name         = "regional-do-deployment"
      description  = "Regional Deployment of DigitalOcean-specific Resources"
      homepage_url = "https://go.workloads.io/do-regional"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "digital-ocean",
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
      description  = "Terraform-managed Regional HCP Terraform Workspaces"
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
      name         = "terraform-aws-regional-cidrs"
      description  = "Terraform Module: Regional CIDRs for AWS"
      homepage_url = "https://registry.terraform.io/modules/workloads/regional-cidrs/aws/latest"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "aws",
        "terraform",
        "terraform-module",
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
      name         = "web-assets-sync"
      description  = "Terraform-managed Public Assets Sync"
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
      name         = "website-deployment"
      description  = "Website Deployment for @workloads"
      homepage_url = "https://github.com/workloads/website"
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
      }, {
      name         = "workspaces"
      description  = "Terraform-managed HCP Terraform Workspaces"
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

variable "tool_versions_config" {
  type = map(object({
    version = string
  }))

  description = "List of Tool Versions."

  default = {
    hugo = {
      # see https://github.com/gohugoio/hugo/releases
      version = "v0.121.0"
    },

    terraform_docs = {
      # see https://github.com/terraform-docs/terraform-docs/releases
      version = "v0.17.0"
    },

    vale = {
      # see https://github.com/errata-ai/vale/releases
      version = "2.30.0"
    },
  }
}

locals {
  # list of files to manage for ALL GitHub Repositories.
  repository_files = [
    {
      file = ".github/workflows/superlinter.yml"
      content = templatefile("./templates/workflows/superlinter.tftpl.yml", {
        checkout    = local.actions_config["checkout"]
        superlinter = local.actions_config["superlinter"]
      })

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
