
resource "aws_api_gateway_stage" "stage_test" {
  deployment_id = aws_api_gateway_deployment.dev_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "test"
}

resource "aws_api_gateway_stage" "stage_staging" {
  deployment_id = aws_api_gateway_deployment.dev_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "staging"
}

resource "aws_api_gateway_stage" "stage_prod" {
  deployment_id = aws_api_gateway_deployment.dev_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "prod"
}
