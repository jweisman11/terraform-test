# GENERAL PROVIDER CONFIG
# https://developer.hashicorp.com/terraform/language/providers/configuration

# AWS PROVIDER CONFIG
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs


# default provider
# use `profile` to change which environment to deploy to
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

# alternative provider
provider "aws" {
  alias  = "west"
  region = "us-west-1"
}
