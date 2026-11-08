provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      MVP         = "MVP8"
      Project     = "Residencia-Cloud"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}