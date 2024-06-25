# General Deployment Variables
variable "aws_region" {
  type        = string
  default = "ap-southeast-1"
  description = "AWS region"
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
