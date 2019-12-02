resource "aws_cloudwatch_log_group" "knowbe4" {
  name              = "/aws/lambda/${local.function_name}"
  retention_in_days = var.log_retention
  tags              = local.tags
}

resource "aws_cloudwatch_event_rule" "scheduled_events" {
  count               = length(var.scheduled_events)
  description         = "Rule for ${var.app}-${var.service}-${count.index}"
  schedule_expression = lookup(var.scheduled_events[count.index], "schedule_expression")
}

resource "aws_cloudwatch_event_target" "scheduled_events" {
  count = length(var.scheduled_events)
  rule  = aws_cloudwatch_event_rule.scheduled_events[count.index].id
  arn   = aws_lambda_function.main.arn
  input = jsonencode(lookup(var.scheduled_events[count.index], "data", {}))
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  count         = length(var.scheduled_events)
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main.function_name
  principal     = "events.amazonaws.com"
  source_arn    = element(aws_cloudwatch_event_rule.scheduled_events.*.arn, count.index)
}
