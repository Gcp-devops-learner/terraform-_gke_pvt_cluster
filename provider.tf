# terraform {
#   required_providers {
#     google = {
#       version = "~> 4.0"
#     }

#     google-beta = {
#       version = "~> 4.0"
#     }
#   }
# }

# Google Cloud Platform Provider
# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  region = "us-west2"
}


terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.66"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}