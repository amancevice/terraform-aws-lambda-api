provider archive {
  version = "~> 1.1"
}

provider aws {
  profile = "bdsa"
  region  = "us-east-1"
  version = "~> 1.57"
}

data archive_file package {
  source_file = "${path.module}/index.js"
  output_path = "${path.module}/package.zip"
  type        = "zip"
}

module role {
  source = "amancevice/lambda-basic-execution-role/aws"
  name   = "example"
}

module api {
  source                  = "amancevice/lambda-api/aws"
  api_name                = "example"
  lambda_function_name    = "example"
  lambda_handler          = "index.handler"
  lambda_runtime          = "nodejs8.10"
  lambda_role_arn         = "${module.role.role_arn}"
  lambda_filepath         = "${data.archive_file.package.output_path}"
  lambda_source_code_hash = "${data.archive_file.package.output_base64sha256}"
}
