# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_usage_plan
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_usage_plan_key

resource "aws_api_gateway_usage_plan" "aws_api_usage_plan" {
  name        = "my-usage-plan"
  description = "my description"

  api_stages {
    api_id = aws_api_gateway_rest_api.api.id
    stage  = aws_api_gateway_stage.stage_test.stage_name
  }

  quota_settings {
    limit  = 20
    offset = 2
    period = "WEEK"
  }

  throttle_settings {
    burst_limit = 5
    rate_limit  = 10
  }
}

resource "aws_api_gateway_usage_plan_key" "aws_api_usage_plan_key" {
  key_id        = aws_api_gateway_api_key.api_key_jeff.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.aws_api_usage_plan.id
}
