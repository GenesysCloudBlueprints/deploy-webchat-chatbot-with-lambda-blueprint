resource "aws_lambda_function" "lambda_function" {
  function_name    = "${local.resource_name_prefix}-lambda"
  description      = "Lambda to be consumed by Genesys Cloud Architect Flow"
  filename         = var.lambda_zip_file
  handler          = "bootstrap"
  source_code_hash = var.lambda_source_code_hash
  role             = aws_iam_role.lambda_execution_role.arn
  runtime          = local.go_runtime
  architectures    = local.architectures
  timeout          = local.lambda_timeout
}
