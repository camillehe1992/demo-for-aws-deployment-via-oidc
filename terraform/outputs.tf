output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.this.website_endpoint
}

# output "dist_files" {
#   value = data.local_file.dist.filename
# }
