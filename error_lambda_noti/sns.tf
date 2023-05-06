resource "aws_sns_topic" "lambda_error" {
  name = "lambda_error"
}
resource "aws_sns_topic_subscription" "subscription_sns_error_log" {
  topic_arn = aws_sns_topic.lambda_error.arn
  protocol  = "email"
  endpoint  = "congtung.07011999@gmail.com"
}
