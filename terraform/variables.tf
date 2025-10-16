variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "domain_name" {
  type    = string
  default = "luigimatera.eu"
}

variable "site_dir" {
  type    = string
  default = "../site"  # relative path from terraform directory to site files
}

variable "tags" {
  type = map(string)
  default = {
    Project = "portfolio-site"
    Env     = "production"
    }
}
