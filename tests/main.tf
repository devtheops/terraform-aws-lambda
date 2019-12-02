provider "aws" {
  region = "us-east-1"
}

locals {
  env_vars = {
    ONE   = "TWO"
    THREE = "FOUR"
  }
}


module "test" {
  source         = "../."
  app            = "testapp-test-no-env-vars"
  service        = "api"
  env            = "test"
  description    = "test lambda."
  lambda_zipfile = "./test.zip"
  runtime        = "python3.6"
  timeout        = "10"
  handler        = "portal.api.handler"
  memory_size    = "2048"
  env_vars       = local.env_vars
}

module "test-with-vpc" {
  source         = "../."
  app            = "testapp-test-no-env-vars"
  service        = "api"
  env            = "test"
  description    = "test lambda."
  lambda_zipfile = "./test.zip"
  runtime        = "python3.6"
  timeout        = "10"
  handler        = "portal.api.handler"
  memory_size    = "2048"
  env_vars       = local.env_vars
  vpc_config = {
    subnet_ids         = ["abcdefg"]
    security_group_ids = ["sg-wrwerwerwrwer"]
  }
}

module "test-no-env-vars" {
  source         = "../."
  app            = "testapp-test-no-env-vars"
  service        = "api"
  env            = "test"
  description    = "test lambda."
  lambda_zipfile = "./test.zip"
  runtime        = "python3.6"
  timeout        = "10"
  handler        = "portal.api.handler"
  memory_size    = "2048"
}

module "test-with-function-name" {
  source         = "../."
  app            = "testapp-test-no-env-vars"
  service        = "api"
  env            = "test"
  description    = "test lambda."
  lambda_zipfile = "./test.zip"
  function_name  = "testapp-test-no-env-vars"
  runtime        = "python3.6"
  timeout        = "10"
  handler        = "portal.api.handler"
  memory_size    = "2048"
}

module "test-with-extra-principals" {
  source                = "../."
  app                   = "testapp-test-no-env-vars"
  service               = "api"
  env                   = "test"
  description           = "test lambda."
  lambda_zipfile        = "./test.zip"
  runtime               = "python3.6"
  timeout               = "10"
  handler               = "portal.api.handler"
  memory_size           = "2048"
  env_vars              = local.env_vars
  extra_role_principals = ["sagemaker.amazonaws.com"]
}


module "test-with-extra-scheduled_events" {
  source         = "../."
  app            = "testapp-test-no-env-vars"
  service        = "api"
  env            = "test"
  description    = "test lambda."
  lambda_zipfile = "./test.zip"
  runtime        = "python3.6"
  timeout        = "10"
  handler        = "portal.api.handler"
  memory_size    = "2048"
  env_vars       = local.env_vars
  scheduled_events = [{
    schedule_expression = "cron(00 19 ? * WED *)"
    data                = {}
  }]
}

module "test-with-long-name" {
  source         = "../."
  app            = "testapp-test-no-env-vars"
  function_name  = "this-is-a-really-long-name-that-should-be-longer-than-55-characters"
  service        = "api"
  env            = "test"
  description    = "test lambda."
  lambda_zipfile = "./test.zip"
  runtime        = "python3.6"
  timeout        = "10"
  handler        = "portal.api.handler"
  memory_size    = "2048"
  env_vars       = local.env_vars
}
