variable "repo_count" {
  type        = number
  description = "Number of repositories"
  default     = 1
  validation {
    condition     = var.repo_count < 5
    error_message = "Do not deploy more than 5 repositories"
  }
}

variable "env" {
  type        = string
  description = "Deployment env"
  validation {
    # condition = var.env == "dev" || var.env == "prod"
    condition     = contains(["dev", "prod"], var.env)
    error_message = "Env must be 'dev' or 'prod' "
  }
}

# variable "varsource" {
#   type = string
#   description = "Source used to define variables"
#   default = "variables.tf"
# }

# variable "visitiblity" {
#   type = string
#   description = "Visibility of the repo"
#   default = var.env == "dev" ? "private" : "public"
#  }

variable repos {
  type = set(string)
  description = "multiple repositories"

}  