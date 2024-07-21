resource "random_id" "random" {
  byte_length = 2
  count       = var.repo_count
}


resource "github_repository" "mtc_repo_a" {
  count       = var.repo_count
  name        = "mtc-repo-${random_id.random[count.index].dec}"
  description = "Code for MTCa"
  visibility  = "private"
  auto_init   = true
}

resource "github_repository_file" "readme" {
  count               = var.repo_count
  repository          = github_repository.mtc_repo_a[count.index].name
  branch              = "main"
  file                = "README.md"
  content             = " # This is a repo for infra developers"
  overwrite_on_create = true
}

# # # Terraform Apply Yourself!
# # # 1. New file in the repo
# # # 2. main branch
# # # 3. index.html
# # # 4. overwrite on overwrite_on_create
# # # 5. hello terraform!

resource "github_repository_file" "index" {
  count               = var.repo_count
  repository          = github_repository.mtc_repo_a[count.index].name
  branch              = "main"
  file                = "index.html"
  content             = "Hello Terraform!"
  overwrite_on_create = true
}

# output "repo-name" {
#   value =  github_repository.mtc_repo_a[*].name
#   description = "Repository names"
#   sensitive = true
# }

output "clone-urls" {
  value       = { for i in github_repository.mtc_repo_a : i.name => i.http_clone_url }
  description = "Repo names and URLS"
  sensitive   = false
}