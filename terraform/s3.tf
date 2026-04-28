# -----------------------------------------------
# S3 BUCKET
# -----------------------------------------------
resource "aws_s3_bucket" "sensitive_data" {
  bucket = var.bucket_name

  tags = {
    Name        = "Sensitive Data Simulation"
    Environment = "Security-Lab"
  }
}

# Block ALL public access — #1 S3 security control
resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.sensitive_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning for data integrity
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.sensitive_data.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.sensitive_data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# -----------------------------------------------
# BUCKET POLICY — Deny specific user (amarrow)
# -----------------------------------------------
resource "aws_s3_bucket_policy" "deny_amarrow" {
  bucket = aws_s3_bucket.sensitive_data.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "DenyAmarrowAccess"
        Effect = "Deny"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/amarrow"
        }
        Action   = "s3:*"
        Resource = "${aws_s3_bucket.sensitive_data.arn}/*"
      }
    ]
  })
}

# Fetch current account ID dynamically (no hardcoded account IDs)
data "aws_caller_identity" "current" {}
