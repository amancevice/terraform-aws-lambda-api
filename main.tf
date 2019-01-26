resource aws_api_gateway_deployment deployment {
  depends_on  = [
    "aws_api_gateway_integration.get",
    "aws_api_gateway_integration.proxy_any",
    "aws_api_gateway_method.get",
    "aws_api_gateway_method.proxy_any",
  ]
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name  = "${var.api_stage_name}"
}

resource aws_api_gateway_integration get {
  content_handling        = "CONVERT_TO_TEXT"
  http_method             = "${aws_api_gateway_method.get.http_method}"
  integration_http_method = "POST"
  resource_id             = "${aws_api_gateway_rest_api.api.root_resource_id}"
  rest_api_id             = "${aws_api_gateway_rest_api.api.id}"
  timeout_milliseconds    = "${var.api_timeout}"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.lambda.invoke_arn}"
}

resource aws_api_gateway_integration proxy_any {
  content_handling        = "CONVERT_TO_TEXT"
  http_method             = "${aws_api_gateway_method.proxy_any.http_method}"
  integration_http_method = "POST"
  resource_id             = "${aws_api_gateway_resource.proxy.id}"
  rest_api_id             = "${aws_api_gateway_rest_api.api.id}"
  timeout_milliseconds    = "${var.api_timeout}"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.lambda.invoke_arn}"
}

resource aws_api_gateway_method get {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
}

resource aws_api_gateway_method proxy_any {
  authorization = "NONE"
  http_method   = "ANY"
  resource_id   = "${aws_api_gateway_resource.proxy.id}"
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
}

resource aws_api_gateway_resource proxy {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "{proxy+}"
}

resource aws_api_gateway_rest_api api {
  description = "${var.api_description}"
  name        = "${var.api_name}"
}

resource aws_cloudwatch_log_group logs {
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = "${var.log_group_retention_in_days}"
  tags              = "${var.log_group_tags}"
}

resource aws_lambda_function lambda {
  description      = "${var.lambda_description}"
  filename         = "${var.lambda_filename}"
  function_name    = "${var.lambda_function_name}"
  handler          = "${var.lambda_handler}"
  kms_key_arn      = "${var.lambda_kms_key_arn}"
  layers           = "${var.lambda_layers}"
  memory_size      = "${var.lambda_memory_size}"
  publish          = "${var.lambda_publish}"
  role             = "${var.lambda_role_arn}"
  runtime          = "${var.lambda_runtime}"
  source_code_hash = "${var.lambda_source_code_hash}"
  tags             = "${var.lambda_tags}"
  timeout          = "${var.lambda_timeout}"

  dead_letter_config {
    target_arn = "${var.lambda_dead_letter_config_target_arn}"
  }

  environment {
    variables = "${var.lambda_environment_variables}"
  }

  vpc_config {
    subnet_ids         = ["${var.lambda_subnet_ids}"]
    security_group_ids = ["${var.lambda_security_group_ids}"]
  }
}

resource aws_lambda_permission invoke {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda.arn}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*/*"
}
