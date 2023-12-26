terraform {
  required_version = ">=0.12.0"
}

module "aws_api_gateway" {
  source = "./modules/api"
}

module "aws_lambda_function" {
  source = "./modules/lambda"
}
