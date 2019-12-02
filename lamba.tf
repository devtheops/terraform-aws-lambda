## TODO: Add kms integration

data "template_file" "description" {
  template = "This module creates a lambda resource, assume role policy, vpc policy and a role to attach the policies and the lambda too."
}

resource "aws_lambda_function" "main" {
  filename         = var.lambda_zipfile
  function_name    = local.function_name
  description      = var.description
  role             = aws_iam_role.main.arn
  handler          = var.handler
  source_code_hash = filebase64sha256(var.lambda_zipfile)
  runtime          = var.runtime
  timeout          = var.timeout
  memory_size      = var.memory_size
  publish          = true

  tracing_config {
    mode = var.tracing_mode
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config != null ? [1] : []
    content {
      subnet_ids         = var.vpc_config["subnet_ids"]
      security_group_ids = var.vpc_config["security_group_ids"]
    }
  }

  tags = local.tags

  dynamic "environment" {
    for_each = var.env_vars != null ? [1] : []
    content {
      variables = var.env_vars
    }
  }

  depends_on = [
    aws_iam_role.main,
    aws_iam_policy_attachment.vpc-attach,
    aws_iam_policy_attachment.xray-attach,
  ]
}
