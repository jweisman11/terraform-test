# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function

data "archive_file" "lambda_package" {
  type        = "zip"
  source_file = "./modules/lambda/lambda_function.py"
  output_path = "lambda_function_payload.zip"
}

# If the file is not in the current working directory you will need to include a
# path.module in the filename.
resource "aws_lambda_function" "aws_lambda_get_health" {
  filename      = "lambda_function_payload.zip"
  function_name = "lambda-function-name"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_handler"

  source_code_hash = data.archive_file.lambda_package.output_base64sha256

  runtime = "python3.12"

  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.aws_lambda_get_health.function_name
  principal = "apigateway.amazonaws.com"

  source_arn = "${var.deployment_execution_arn}/*/*/*"
}
