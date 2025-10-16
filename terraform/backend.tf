terraform {
  backend "s3" {
    bucket = "my-remote-terraform-states-405989524795"
    key    = "portfolio/site/terraform.tfstate"
    region = "eu-central-1"
    encrypt = true
  }
}
