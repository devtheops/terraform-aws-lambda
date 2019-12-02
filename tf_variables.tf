variable "app" {
  description = "The Tag Project"
}

variable "service" {
  description = "service"
}

variable "env" {
  description = "environment"
  type        = string
}

variable "description" {
  description = "Description of what your Lambda Function does."
}

variable "lambda_zipfile" {
  description = "The path to the function's deployment package within the local filesystem."
}

variable "function_name" {
  description = "Overrides the default (e.g: $app-$service-$env). A unique name for your Lambda Function."
  default     = ""
}

variable "runtime" {
  description = "See [Runtimes](https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime) for valid values."
  default     = "nodejs4.3"
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds. Defaults to 3. See [Limits](https://docs.aws.amazon.com/lambda/latest/dg/limits.html)"
  default     = "3"
}

variable "memory_size" {
  description = "The amount of memory your Lambda Function has to run on. Defaults to 128. See [Limits](https://docs.aws.amazon.com/lambda/latest/dg/limits.html)"
  default     = "128"
}

variable "handler" {
  description = "The function entrypoint in your code."
}

variable "env_vars" {
  description = "A map of the environment variables you wish to be on the function."
  type        = map(string)
  default     = {}
}

variable "vpc_config" {
  description = "An object with A list of subnet IDs and security group IDs associated with the Lambda function."
  type = object({
    subnet_ids         = list(string)
    security_group_ids = list(string)
  })
  default = null
}

variable "tracing_mode" {
  default = "PassThrough"
}

variable "extra_tags" {
  description = "Extra tags to add to the default tags."
  default     = {}
}

variable "log_retention" {
  description = "How many days do you want to keep the logs?"
  default     = 30
}

variable "extra_role_principals" {
  type    = list(string)
  default = []
}


variable "scheduled_events" {
  description = <<EOF
  Expected structure:

  type = list(object({
    schedule_expression = string
    data = object
  }))
EOF
  type = list(object({
    schedule_expression = string
    data                = map(any)
  }))
  default = []
}
