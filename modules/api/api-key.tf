# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_api_key

resource "aws_api_gateway_api_key" "api_key_jeff" {
  description = "API Key for Customer = Jeff"
  name        = "Jeff's API Key"
  enabled     = true
}
