output "function_arn" {
  value       = aws_lambda_function.main.arn
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function."
}

output "function_name" {
  value       = aws_lambda_function.main.function_name
  description = "A unique name for your Lambda Function."
}

output "function_version" {
  value       = aws_lambda_function.main.version
  description = "Latest published version of your Lambda Function."
}

output "function_invoke_arn" {
  value       = aws_lambda_function.main.invoke_arn
  description = "The ARN to be used for invoking Lambda Function from API Gateway - to be used in (aws_api_gateway_integration)[https://www.terraform.io/docs/providers/aws/r/api_gateway_integration.html]'s uri"
}

output "role_arn" {
  value       = aws_iam_role.main.arn
  description = "The Amazon Resource Name (ARN) specifying the role."
}

output "role_name" {
  value       = aws_iam_role.main.name
  description = "name of the role."
}

