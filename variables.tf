variable api_description {
  description = "API Gateway REST API description."
  default     = ""
}

variable api_name {
  description = "API Gateway REST API name."
}

variable api_stage_name {
  description = "API Gateway REST API deployment stage name."
  default     = "prod"
}

variable api_timeout {
  description = "API Gateway integration timeout in milliseconds."
  default     = 29000
}

variable lambda_description {
  description = "Lambda description."
  default     = ""
}

variable lambda_environment_variables {
  description = "Lambda environment variables."
  default     = {}
  type        = "map"
}

variable lambda_filename {
  description = "Lambda package filename."
}

variable lambda_function_name {
  description = "Lambda function name."
}

variable lambda_handler {
  description = "Lambda handler."
}

variable lambda_kms_key_arn {
  description = "Lambda KMS key ARN."
  default     = ""
}

variable lambda_layers {
  description = "Lambda layer ARNs."
  default     = []
  type        = "list"
}

variable lambda_memory_size {
  description = "Lambda memory size."
  default     = 128
}

variable lambda_publish {
  description = "Publish creation/change as new Lambda Function Version."
  default     = false
}

variable lambda_role_arn {
  description = "Lambda IAM role ARN."
}

variable lambda_runtime {
  description = "Lambda runtime."
}

variable lambda_security_group_ids {
  description = "VPC Lambda security group IDs."
  default     = []
  type        = "list"
}

variable lambda_source_code_hash {
  description = "Lambda source code hash."
  default     = ""
}

variable lambda_subnet_ids {
  description = "VPC Lambda subnet IDs."
  default     = []
  type        = "list"
}

variable lambda_tags {
  description = "Lambda resource tags."
  default     = {}
  type        = "map"
}

variable lambda_timeout {
  description = "Lambda timeout."
  default     = 3
}

variable log_group_retention_in_days {
  description = "CloudWatch log group retention."
  default     = 30
}

variable log_group_tags {
  description = "CloudWatch log group tags."
  default     = {}
  type        = "map"
}

variable s3_bucket {
  description = "Lambda package S3 bucket."
  default     = ""
}

variable s3_key {
  description = "Lambda package S3 key."
  default     = ""
}

variable s3_object_version {
  description = "Lambda package S3 object version."
  default     = ""
}
