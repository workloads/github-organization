variable "issue_labels" {
  type = list(object({
    color       = string
    description = string
    name        = string
  }))

  description = "List of Issue Label Objects."
}

variable "repository" {
  type        = string
  description = "GitHub Repository for Issue Labels."
}
