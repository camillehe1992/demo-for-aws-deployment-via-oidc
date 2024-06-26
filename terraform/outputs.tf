output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.this.website_endpoint
}

# output "website_files" {
#   value = local.website_files
# }
