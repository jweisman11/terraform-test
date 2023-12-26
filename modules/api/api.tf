# Amazon API Gateway Version 1 resources are used for creating and deploying REST APIs. To create and deploy WebSocket and HTTP APIs, use Amazon API Gateway Version 2 resources.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_account


# Manages an API Gateway REST API
resource "aws_api_gateway_rest_api" "api" {
  description = "Proxy to handle requests to our API"
  name        = var.aws_api_gateway_name
}

/*
API Resources

Examples:
/health
/v1/usper_status

*/

resource "aws_api_gateway_resource" "resource_health" {
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "health"
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_resource" "resource_version" {
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "v1"
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_resource" "resource_usper_status" {
  parent_id   = aws_api_gateway_resource.resource_version.id
  path_part   = "usper_status"
  rest_api_id = aws_api_gateway_rest_api.api.id
}




/*
API Methods

Examples:
GET
POST

*/

resource "aws_api_gateway_method" "get_health" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource_health.id
  http_method   = "GET"
  authorization = "NONE"
}

# resource "aws_api_gateway_method" "get_usper_status" {
#   rest_api_id   = aws_api_gateway_rest_api.api.id
#   resource_id   = aws_api_gateway_resource.resource_usper_status.id
#   http_method   = "GET"
#   authorization = "NONE"
# }



# Provides an HTTP Method Integration for an API Gateway Integration
resource "aws_api_gateway_integration" "api_integration" {
  http_method = aws_api_gateway_method.get_health.http_method
  resource_id = aws_api_gateway_resource.resource_health.id
  rest_api_id = aws_api_gateway_rest_api.api.id
  type        = "MOCK"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
}

# Manages an API Gateway Stage
resource "aws_api_gateway_stage" "stage_dev" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = var.aws_api_gateway_stage_name
}
