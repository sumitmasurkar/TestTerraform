provider "aws" {
  region = "ap-south-1"
}
resource "aws_s3_bucket" "data_bucket" {
  bucket = "my-bucket-${random_string.bucket_suffix.result}"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name        = "Data Ingestion Bucket"
    Environment = "Dev"
  }
}
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}
output "bucket_name" {
  value = aws_s3_bucket.data_bucket.id
}
