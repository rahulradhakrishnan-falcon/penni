terraform {
  backend "s3" {
    // bucket and table managed outside of terraform
    bucket         = "your-terraform-state-bucket"
    key            = "static-file-hosting.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "your-terraform-lock-table"
    profile        = "your-aws-profile"
  }
}