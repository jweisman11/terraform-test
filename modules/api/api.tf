# Amazon API Gateway Version 1 resources are used for creating and deploying REST APIs. To create and deploy WebSocket and HTTP APIs, use Amazon API Gateway Version 2 resources.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_account


# Manages an API Gateway REST API
resource "aws_api_gateway_rest_api" "api" {
  description = "Proxy to handle requests to our API"
  name        = var.aws_api_gateway_name

  endpoint_configuration {
    types = ["EDGE"]
  }
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

Each method needs 3 accompanying resources:
1) aws_api_gateway_integration
2) aws_api_gateway_method_response
3) aws_api_gateway_integration_response

*/

####### GET /HEALTH ########
resource "aws_api_gateway_method" "get_health" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource_health.id
  http_method   = "GET"
  authorization = "NONE"
  api_key_required = true
}

resource "aws_api_gateway_integration" "get_health_lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource_health.id
  http_method = aws_api_gateway_method.get_health.http_method
  integration_http_method = "GET"
  type = "MOCK"
}

resource "aws_api_gateway_method_response" "get_health_method_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource_health.id
  http_method = aws_api_gateway_method.get_health.http_method
  status_code = 200
}

resource "aws_api_gateway_integration_response" "get_health_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource_health.id
  http_method = aws_api_gateway_method.get_health.http_method
  status_code = aws_api_gateway_method_response.get_health_method_response.status_code

  depends_on = [
    aws_api_gateway_method.get_health,
    aws_api_gateway_integration.get_health_lambda_integration
  ]
}



/*
Deployment for all API integrations
*/

resource "aws_api_gateway_deployment" "dev_deployment" {
  depends_on = [
    aws_api_gateway_integration.get_health_lambda_integration,
  ]

  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name = "dev"
}
