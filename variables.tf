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
    description  = ":octocat: Default Community Health files for @workloads."
    homepage_url = "https://github.com/workloads"
    visibility   = "public"
    has_issues   = true
    has_wiki     = false

    topics = [
      "github",
      "github-organization",
      "community",
      "community-health",
    ]

    allow_merge_commit     = false
    allow_rebase_merge     = false
    delete_branch_on_merge = true

    },
    {
      name         = "assets"
      description  = ":card_index_dividers: Design and Content Assets."
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
      name         = "workspaces"
      description  = ":building_construction: Terraform Cloud Workspaces."
      homepage_url = "https://app.terraform.io/app/workloads/workspaces"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "hashicorp-terraform",
        "terraform-cloud",
        "terraform-enterprise",
        "terraform-workspaces",
      ]

      allow_merge_commit     = false
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
    {
      name         = "github-organization"
      description  = ":octocat: Terraform-managed GitHub Resources."
      homepage_url = "https://app.terraform.io/app/workloads/workspaces/repositories"
      visibility   = "public"
      has_issues   = true
      has_wiki     = false

      topics = [
        "hashicorp-terraform",
        "terraform-cloud",
        "terraform-enterprise",
        "terraform-workspaces",
        "terraform-github-provider",
      ]

      allow_merge_commit     = false
      allow_rebase_merge     = false
      delete_branch_on_merge = true
    },
  ]
}
