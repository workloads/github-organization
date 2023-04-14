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
    # see https://github.com/actions/checkout/releases
    checkout = {
      owner      = "actions"
      repository = "checkout"
      version    = "v3.5.2"
    }

    # see https://github.com/github/codeql-action/releases
    codeql_upload = {
      owner      = "github"
      repository = "codeql-action"
      path       = "upload-sarif"
      version    = "codeql-bundle-20230403"
    }

    # see https://github.com/gaurav-nelson/github-action-markdown-link-check/releases
    markdown = {
      owner      = "gaurav-nelson"
      repository = "github-action-markdown-link-check"
      version    = "1.0.15"
    }

    #    # see # https://github.com/snyk/actions/releases
    #    snyk_iac = {
    #      owner      = "snyk"
    #      repository = "actions"
    #      path       = "iac"
    #      version    = "master"
    #    }

    # see https://github.com/github/super-linter/releases
    superlinter = {
      owner      = "github"
      repository = "super-linter"
      path       = "slim"
      version    = "v5.0.0"
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
      name         = "edge-case"
      description  = "Docs and Diagrams for the Edge Case."
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
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "edge-case-docs"
      description  = "🔒 (non-public) Docs for the Edge Case."
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
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "nomad-pack-registry"
      description  = "Nomad Pack Registry."
      homepage_url = ""
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "nomad",
        "nomad-packs"
      ]

      allow_merge_commit     = false
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "packer-templates"
      description  = "Packer Templates for common Cloud Providers."
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
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
  ]
}

variable "special_repositories" {
  type = list(object({
    name                   = string
    description            = string
    homepage_url           = string
    visibility             = string
    topics                 = list(string)
    has_issues             = bool # TODO: mark as optional when 1.3.0 is out
    has_wiki               = bool # TODO: mark as optional when 1.3.0 is out
    allow_merge_commit     = bool
    allow_rebase_merge     = bool
    delete_branch_on_merge = bool
  }))

  description = "List of non-Terraform-based GitHub Repositories."

  default = [{
    name         = ".github"
    description  = "Community Health Files and Assets."
    homepage_url = "https://github.com/workloads"
    visibility   = "public"
    has_issues   = true
    has_wiki     = false

    topics = [
      "github",
    ]

    allow_merge_commit     = true
    allow_rebase_merge     = false
    delete_branch_on_merge = true
    },
    {
      name         = "assets"
      description  = "🔒 (non-public) Design and Content Assets."
      homepage_url = "https://github.com/workloads"
      visibility   = "private"
      has_issues   = true
      has_wiki     = false

      topics = []

      allow_merge_commit     = false
      allow_rebase_merge     = false
      delete_branch_on_merge = true
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
      name         = "dns"
      description  = "Terraform-managed DNS Resources."
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
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "github-organization"
      description  = "Terraform-managed GitHub Resources."
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
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "networking"
      description  = "Terraform-managed Networking Components."
      homepage_url = "https://app.terraform.io/app/workloads/workspaces/networking"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "aws",
        "terraform",
      ]

      allow_merge_commit     = false
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "regional-aws-deployment"
      description  = "Regional Deployment of AWS-specific Resources."
      homepage_url = "https://app.terraform.io/app/workloads/workspaces?tag=regional-provider%3Aaws"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "aws",
        "terraform",
      ]

      allow_merge_commit     = false
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "regional-workspaces"
      description  = "Terraform-managed Regional Terraform Cloud (TFC) Workspaces."
      homepage_url = "https://app.terraform.io/app/workloads/regional-workspaces"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "terraform",
        "aws",
      ]

      allow_merge_commit     = false
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "services-configuration"
      description  = "Terraform-managed Services Configuration."
      homepage_url = "https://app.terraform.io/app/workloads/workspaces/services-configuration"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "terraform",
        "vault",
      ]

      allow_merge_commit     = false
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "services-deployment"
      description  = "Terraform-managed Services Deployment."
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
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "website"
      description  = "Terraform-rendered, GitHub-infused Project Website."
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
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "workspaces"
      description  = "Terraform-managed Terraform Cloud (TFC) Workspaces."
      homepage_url = "https://app.terraform.io/app/workloads/workspaces"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "terraform",
      ]

      allow_merge_commit     = false
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
  ]
}

locals {
  # list of files to manage for the GitHub Repository.
  repository_files = [
    {
      file = ".github/workflows/markdown.yml",
      content = templatefile("./templates/workflows/markdown.tftpl.yml", {
        checkout = var.actions_config.checkout
        markdown = var.actions_config.markdown
      })

      overwrite_on_create = true
    },
    {
      file                = ".github/workflows/superlinter.yml"
      content             = templatefile("./templates/workflows/superlinter.tftpl.yml", var.actions_config)
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

  terraform_repository_files = concat(local.repository_files, [
    {
      file                = ".gitignore"
      content             = file("./templates/gitignores/terraform.gitignore")
      overwrite_on_create = true
    },
    {
      file                = ".github/dependabot.yml"
      content             = file("./templates/dependabot/terraform.yml")
      overwrite_on_create = true
    },
    {
      file                = ".github/workflows/terraform.yml"
      content             = templatefile("./templates/workflows/terraform.tftpl.yml", var.actions_config)
      overwrite_on_create = true
    },
    {
      file                = ".github/workflows/terraform-docs.yml"
      content             = templatefile("./templates/workflows/terraform-docs.tftpl.yml", var.actions_config)
      overwrite_on_create = true
    },
    {
      file                = ".terraform-docs.yml"
      content             = file("./templates/.terraform-docs.yml")
      overwrite_on_create = true
    },
    {
      file                = ".tflint.hcl"
      content             = file("./templates/.tflint.hcl")
      overwrite_on_create = true
    },
  ])
}
