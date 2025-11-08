terraform {
  backend "s3" {
    
  }
  required_providers {
      helm = {
        source  = "hashicorp/helm"
        version = "~> 2.11"
      }
      kubernetes = {
        source  = "hashicorp/kubernetes"
        version = "~> 2.29"
      }
    }
}