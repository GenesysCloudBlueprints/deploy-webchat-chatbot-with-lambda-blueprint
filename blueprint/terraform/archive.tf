data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${local.lambda_zip_dir}/main"
  output_path = "${local.lambda_zip_dir}/function.zip"
}
