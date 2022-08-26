variable "github_owner" {
  type        = string
  description = "This is the target GitHub organization or individual user account to manage."
}

variable "github_token" {
  type        = string
  description = "A GitHub OAuth / Personal Access Token."
  sensitive   = true
}

variable "organization_owners" {
  type        = list(string)
  description = "User Names of GitHub Organization Owners."

  default = [
    "DerekStrickland", # Derek Strickland
    "ksatirli",        # Kerim Satirli
    "workloads-bot",   # service account
  ]
}

variable "organization_members" {
  type        = list(string)
  description = "User Names of GitHub Organization Members."

  default = [
    "drewmullen",    # Drew Mullen (AWS)
    "im2nguyen",     # Tu Nguyen (HashiCorp)
    "joatmon08",     # Rosemary Wang (HashiCorp)
    "justinretzolk", # Justin Retzolk (HashiCorp)
    "lhaig",         # Lance Haig (HashiCorp)
    "lomar92",       # Amar Lojo (HashiCorp)
    "straubt1",      # Tom Straub (HashiCorp)
  ]
}

variable "repositories" {
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

  description = "List of GitHub Repositories."

  default = [{
    name         = ".github"
    description  = "Community Health files and assets."
    homepage_url = "https://github.com/workloads"
    visibility   = "public"
    has_issues   = true
    has_wiki     = false

    topics = [
      "github",
    ]

    allow_merge_commit     = false
    allow_rebase_merge     = false
    delete_branch_on_merge = true

    },
    {
      name         = "assets"
      description  = "(non-public) Design and Content Assets."
      homepage_url = "https://github.com/workloads"
      visibility   = "private"
      has_issues   = true
      has_wiki     = false

      topics = []

      allow_merge_commit     = false
      allow_rebase_merge     = false
      delete_branch_on_merge = true

    },
    {
      name         = "github-organization"
      description  = "Terraform-managed GitHub resources."
      homepage_url = "https://app.terraform.io/app/workloads/workspaces/repositories"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "github",
        "terraform",
      ]

      allow_merge_commit     = false
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "networking"
      description  = "Terraform-managed networking resources."
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
      name         = "website"
      description  = "Terraform-rendered, GitHub-infused website."
      homepage_url = "https://workloads.io"
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
