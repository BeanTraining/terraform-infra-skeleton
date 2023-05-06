resource "aws_iam_policy" "error_lambda_policy" {
  name        = "error_lambda_policy"
  description = "Allows Lambda function to publish to an SNS topic and write logs to CloudWatch"

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : "sns:Publish",
        Resource : "arn:aws:sns:${var.aws_region}:${var.aws_account_id}:lambda_error"
      },
      {
        Effect : "Allow",
        Action : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource : "arn:aws:logs:${var.aws_region}:${var.aws_account_id}:log-group:/aws/lambda/${aws_lambda_function.errorlog_lambda.function_name}:*"
      }
    ]
  })
}
resource "aws_iam_role" "error_lambda_role" {
  name = "error_lambda_role"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Service : "lambda.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Name = "MyLambdaCloudwatchRole"
  }
}
resource "aws_iam_role_policy_attachment" "my_policy_attachment" {
  policy_arn = aws_iam_policy.error_lambda_policy.arn
  role       = aws_iam_role.error_lambda_role.name
}

