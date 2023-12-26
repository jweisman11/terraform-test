variable "aws_api_gateway_name" {
  description = "name of the api in api gateway"
  type        = string
  default     = "very-cool-api"
  sensitive   = false
  nullable    = false
}

variable "aws_api_gateway_stage_name" {
  description = "the name of the api stage"
  type        = string
  default     = "dev"
  sensitive   = false
  nullable    = false
  validation {
    condition     = contains(["dev", "stage", "prod"], var.aws_api_gateway_stage_name)
    error_message = "Valid values for var: test_variable are (dev, stage, prod)."
  }
}
