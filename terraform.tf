terraform {
  required_version = "~> 1.1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }

  #   backend "s3" {
  #     bucket  = "tfstate"
  #     key     = "terraform.tfstate"
  #     region  = "ap-northeast-1"
  #     encrypt = true
  #   }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      ManagedBy = "terraform"
    }
  }
}

# CloudFrintのACM作成用
# provider "aws" {
#   region = "us-east-1"
#   alias  = "virginia"

#   default_tags {
#     tags = {
#       ManagedBy   = "terraform"
#     }
#   }
# }