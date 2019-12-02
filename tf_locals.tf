locals {
  function_name = length(var.function_name) > 0 ? var.function_name : "${var.app}-${var.service}-${var.env}"

  tags_default = {
    app     = var.app
    service = var.service
    env     = var.env
  }
  tags = merge(local.tags_default, var.extra_tags)

  base_principals = ["lambda.amazonaws.com"]
  principals      = distinct(concat(local.base_principals, var.extra_role_principals))
}
