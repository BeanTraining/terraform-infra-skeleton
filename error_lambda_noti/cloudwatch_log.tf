resource "aws_cloudwatch_log_group" "error_lambda" {
  name = "/${var.lambda_function_name}"
}

resource "aws_lambda_permission" "cloudwatch_log_trigger_lambda" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.errorlog_lambda.function_name
  principal     = "logs.${var.aws_region}.amazonaws.com"
  source_arn    = "${aws_cloudwatch_log_group.error_lambda.arn}:*"
  depends_on    = [aws_cloudwatch_log_group.error_lambda]
}

resource "aws_cloudwatch_log_subscription_filter" "error-lambda-logs" {
  depends_on      = [aws_lambda_permission.cloudwatch_log_trigger_lambda]
  name            = "error-lambda-logs"
  log_group_name  = aws_cloudwatch_log_group.error_lambda.name
  filter_pattern  = "?ERROR ?WARN ?5xx"
  destination_arn = aws_lambda_function.errorlog_lambda.arn
}
