# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket
resource "aws_s3_bucket" "this" {
  bucket = "${var.static_bucket_name}-${var.environment}"
  tags   = var.tags
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.this,
    aws_s3_bucket_public_access_block.this,
  ]

  bucket = aws_s3_bucket.this.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}
resource "aws_s3_bucket_policy" "this" {
  depends_on = [aws_s3_bucket.this]
  bucket     = aws_s3_bucket.this.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject*"
        Resource = [
          aws_s3_bucket.this.arn,
          "${aws_s3_bucket.this.arn}/*",
        ]
      },
    ]
  })
}

# https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource
resource "null_resource" "dist" {
  triggers = {
    timestamp  = timestamp()
  }

  provisioner "local-exec" {
    command = "rm -rf ${var.website_root} && mkdir ${var.website_root} && cp ../*.html ${var.website_root} && ls ${var.website_root}"
  }
}

# https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file
data "local_file" "dist" {
  depends_on = [ null_resource.dist ]
  for_each = local.website_files

  filename = "${var.website_root}/${each.value}"
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/s3_object
resource "aws_s3_object" "dist" {
  depends_on = [ data.local_file.dist ]
  for_each = local.website_files

  bucket = aws_s3_bucket.this.id
  key    = each.value
  source      = "${var.website_root}/${each.key}"
  source_hash = filemd5("${var.website_root}/${each.key}")
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.key), null)

  tags = var.tags
}
