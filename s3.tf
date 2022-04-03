# S3 bucket for website

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  tags   = var.common_tags
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.bucket.id
  key    = "index.html"
  etag   = filemd5("template/web.html")
}

resource "aws_s3_bucket_object" "error" {
  bucket = aws_s3_bucket.bucket.id
  key    = "error.html"
  etag   = filemd5("template/error.html")
}

resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = aws_s3_bucket.bucket.bucket

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://static.${var.domain_name}"]
    max_age_seconds = 3000
  }
}