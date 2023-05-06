resource "aws_lambda_function" "errorlog_lambda" {
  filename      = "errorlog_lambda_sns.zip"
  function_name = "errorlog_lambda"
  role          = aws_iam_role.error_lambda_role.arn
  handler       = "errorlog_lambda_sns.lambda_handler"
  runtime       = "python3.7"

  environment {
    variables = {
      snsARN = aws_sns_topic.lambda_error.arn
    }
  }

  source_code_hash = filebase64sha256("errorlog_lambda_sns.zip")
}


locals {
  errorlog_lambda_sns_zip_file = "${path.module}/errorlog_lambda_sns.zip"
}

data "archive_file" "errorlog_lambda_sns" {
  type        = "zip"
  output_path = local.errorlog_lambda_sns_zip_file
  source {
    content  = file("${path.module}/errorlog_lambda_sns.py")
    filename = "errorlog_lambda_sns.py"
  }
}