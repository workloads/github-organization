resource "github_repository_file" "organization_profile" {
  repository          = module.special_repositories[".github"].github_repository.name
  file                = "/profile/README.md"
  branch              = "main"
  content             = "test"
  overwrite_on_create = true
}