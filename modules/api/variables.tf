variable "aws_api_gateway_name" {
  description = "name of the api in api gateway"
  type        = string
  default     = "very-cool-api"
  sensitive   = false
  nullable    = false
}
