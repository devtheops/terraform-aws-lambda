data "template_file" "lambda_assume_policy" {
  template = file("${path.module}/files/assume-policy.json")

  vars = {
    principals = jsonencode(local.principals)
  }
}

data "template_file" "lambda_base_policy" {
  template = file("${path.module}/files/base-policy.json")
}

data "template_file" "lambda_vpc_policy" {
  template = file("${path.module}/files/vpc-policy.json")
}

data "template_file" "lambda_xray_policy" {
  template = file("${path.module}/files/xray-policy.json")
}

resource "aws_iam_role" "main" {
  description        = "IAM role for ${local.function_name}"
  assume_role_policy = data.template_file.lambda_assume_policy.rendered
  tags               = local.tags
}


resource "aws_iam_policy" "base-policy" {
  description = "base Policy for ${local.function_name}"
  policy      = data.template_file.lambda_base_policy.rendered
}

resource "aws_iam_policy_attachment" "base-attach" {
  name       = aws_iam_role.main.name
  roles      = [aws_iam_role.main.name]
  policy_arn = join("", aws_iam_policy.base-policy.*.arn)
}


resource "aws_iam_policy" "vpc-policy" {
  count       = var.vpc_config != null ? 1 : 0
  description = "VPC policy for ${local.function_name}"
  policy      = data.template_file.lambda_vpc_policy.rendered
}

resource "aws_iam_policy_attachment" "vpc-attach" {
  count      = var.vpc_config != null ? 1 : 0
  name       = aws_iam_role.main.name
  roles      = [aws_iam_role.main.name]
  policy_arn = join("", aws_iam_policy.vpc-policy.*.arn)
}


resource "aws_iam_policy" "xray-policy" {
  count       = var.tracing_mode == "Active" ? 1 : 0
  description = "xray policy for ${local.function_name}"
  policy      = data.template_file.lambda_xray_policy.rendered
}

resource "aws_iam_policy_attachment" "xray-attach" {
  count      = var.tracing_mode == "Active" ? 1 : 0
  name       = aws_iam_role.main.name
  roles      = [aws_iam_role.main.name]
  policy_arn = join("", aws_iam_policy.xray-policy.*.arn)
}

