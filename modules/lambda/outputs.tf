# https://developer.hashicorp.com/terraform/language/values/outputs
# In a parent module, outputs of child modules are available in expressions as module.<MODULE NAME>.<OUTPUT NAME>. For example, if a child module named web_server declared an output named instance_ip_addr, you could access that value as module.web_server.instance_ip_addr.

output "lambda_invoke_arn" {
  description = "lambda execution arn"
  value = aws_lambda_function.aws_lambda_get_health.invoke_arn
}
