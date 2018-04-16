############################
# S3 Buckets
############################
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.environment}-resources-${var.project_name}"
  acl    = "public-read"

  cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT","POST"]
        allowed_origins = ["*"]
        expose_headers = ["ETag"]
        max_age_seconds = 3000
    }

    policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetTestBucketObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.environment}-resources-${var.project_name}/*"
        }
    ]
}
EOF

  tags {
    Environment = "${var.environment}"
    Project     = "${var.project_name}"
  }
}
