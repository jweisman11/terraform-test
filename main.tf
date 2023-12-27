terraform {
  required_version = ">=0.12.0"
}

module "aws_api_gateway" {
  source = "./modules/api"
  # lambda_invoke_arn = module.aws_lambda_function.lambda_invoke_arn
}

module "aws_lambda_function" {
  source = "./modules/lambda"
  # deployment_execution_arn = module.aws_api_gateway.deployment_execution_arn
}
