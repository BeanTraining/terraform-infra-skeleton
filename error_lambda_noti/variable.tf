variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}
variable "aws_account_id" {
  description = "AWS Account Id"
  type        = string
  default     = "025874527228"
}
variable "lambda_function_name" {
  type    = string
  default = "errorlog_lambda"
}
variable "error_log_group_name" {
  type    = string
  default = "/aws/lambda/error-lambda"
}


