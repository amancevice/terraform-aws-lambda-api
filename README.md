# Lambda API

Simple Lambda-backed REST API.

## Usage

```hcl
// Create basic execution role for Lambda
module role {
  source = "amancevice/lambda-basic-execution-role/aws"
  name   = "example-api"
}

// Create API Gateway REST API + Lambda
module api {
  source                  = "amancevice/lambda-api/aws"
  api_name                = "example-api"
  lambda_function_name    = "example-api"
  lambda_handler          = "index.handler"
  lambda_runtime          = "nodejs8.10"
  lambda_role_arn         = "${module.role.role_arn}"
  lambda_filepath         = "/path/to/lambda/package.zip"
  lambda_source_code_hash = "${base64sha256(file("/path/to/lambda/package.zip"))}"
}
```
