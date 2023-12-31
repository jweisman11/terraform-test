# https://developer.hashicorp.com/terraform/language/values/outputs
# In a parent module, outputs of child modules are available in expressions as module.<MODULE NAME>.<OUTPUT NAME>. For example, if a child module named web_server declared an output named instance_ip_addr, you could access that value as module.web_server.instance_ip_addr.

output "api_deployment_execution_arn" {
  value = module.aws_api_gateway.deployment_execution_arn
}

output "lambda_invoke_arn" {
  value = module.aws_lambda_function.lambda_invoke_arn
}
