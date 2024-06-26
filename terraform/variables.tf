# General Deployment Variables
variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "ap-southeast-1"
}

variable "environment" {
  type        = string
  description = "The environment of application"
}

variable "tags" {
  type        = map(string)
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
}

# Project Specific Variables
variable "static_bucket_name" {
  type        = string
  description = "The name of S3 bucket for static website hosting"
}

variable "website_static_dir" {
  type        = string
  description = "Path to the root directory of website static content"
  default     = "../public"
}
