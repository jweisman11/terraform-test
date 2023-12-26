# Amazon API Gateway Version 1 resources are used for creating and deploying REST APIs. To create and deploy WebSocket and HTTP APIs, use Amazon API Gateway Version 2 resources.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_account


# Manages an API Gateway REST API
resource "aws_api_gateway_rest_api" "example_api" {
  description = "Proxy to handle requests to our API"
  name        = "api-gateway-jeff"
}

resource "aws_api_gateway_method" "post_form" {
  rest_api_id   = aws_api_gateway_rest_api.example_api.id
  resource_id   = aws_api_gateway_rest_api.example_api.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

# Provides an API Gateway Resource
resource "aws_api_gateway_resource" "root_resource" {
  parent_id   = aws_api_gateway_rest_api.example_api.root_resource_id
  path_part   = "v1"
  rest_api_id = aws_api_gateway_rest_api.example_api.id
}

resource "aws_api_gateway_resource" "nested_resource" {
  parent_id = aws_api_gateway_resource.root_resource.id
  path_part = "test"
  rest_api_id = aws_api_gateway_rest_api.example_api.id
}


resource "aws_api_gateway_resource" "nested_resource_third" {
  parent_id = aws_api_gateway_resource.nested_resource.id
  path_part = "deeper"
  rest_api_id = aws_api_gateway_rest_api.example_api.id
}


# Provides an API Gateway Resource
# resource "aws_api_gateway_resource" "example_nested" {
#   parent_id   = aws_api_gateway_resource.example_base.root_resource_id
#   path_part   = "nested"
#   rest_api_id = aws_api_gateway_rest_api.example.id
# }





# # Provides a HTTP Method for an API Gateway Resource.
# resource "aws_api_gateway_method" "example" {
#   authorization = "NONE"
#   http_method   = "GET"
#   resource_id   = aws_api_gateway_resource.example_base.id
#   rest_api_id   = aws_api_gateway_rest_api.example.id
# }

# # Provides an HTTP Method Integration for an API Gateway Integration
# resource "aws_api_gateway_integration" "example" {
#   http_method = aws_api_gateway_method.example.http_method
#   resource_id = aws_api_gateway_resource.example_base.id
#   rest_api_id = aws_api_gateway_rest_api.example.id
#   type        = "MOCK"
# }

# resource "aws_api_gateway_deployment" "example" {
#   rest_api_id = aws_api_gateway_rest_api.example.id
# }

# # Manages an API Gateway Stage
# resource "aws_api_gateway_stage" "example" {
#   deployment_id = aws_api_gateway_deployment.example.id
#   rest_api_id   = aws_api_gateway_rest_api.example.id
#   stage_name    = "example"
# }
