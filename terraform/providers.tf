terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Additional provider configuration for us-east-1 region (for ACM certificate)
provider "aws" {
  alias  = "us_east_1" 
  region = "us-east-1"
}