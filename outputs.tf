output api_id {
  description = "API Gateway REST API ID."
  value       = "${aws_api_gateway_rest_api.api.id}"
}

output api_name {
  description = "API Gateway REST API name."
  value       = "${aws_api_gateway_rest_api.api.name}"
}

output api_stage_name {
  description = "API Gateway REST API deployment stage name."
  value       = "${aws_api_gateway_deployment.deployment.stage_name}"
}

output lambda_function_arn {
  description = "Lambda function ARN."
  value       = "${aws_lambda_function.lambda.arn}"
}

output lambda_function_name {
  description = "Lambda function name."
  value       = "${aws_lambda_function.lambda.function_name}"
}
