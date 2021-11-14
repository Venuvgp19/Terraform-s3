resource "aws_kms_key" "S3-KMS-Key" {
  description             = "KMS key for Lambda s3"
}
data "aws_iam_policy_document" "secure_bucket_policy" {
    statement {
    actions = [
        "s3:GetObject",
        "s3:ListBucket"
      ]
    effect = "Allow"
    resources = [
      "${aws_s3_bucket.S3.arn}",
      "${aws_s3_bucket.S3.arn}/*"
      ]
    principals {
      identifiers = "${var.userids}"
      type        = "AWS"
    }

	}
  statement {
    actions   = [
      "s3:*"
    ]
    condition {
      test      = "Bool"
      values    = [
        "false"
      ]
      variable  = "aws:SecureTransport"
    }
    effect    = "Deny"
    principals {
      identifiers = [
        "*"
      ]
      type        = "AWS"
    }
    resources = [
      "${aws_s3_bucket.S3.arn}",
      "${aws_s3_bucket.S3.arn}/*"
    ]
    sid       = "DenyUnsecuredTransport"
  }
  statement {
    actions   = [
      "s3:PutObject"
    ]
    condition {
      test      = "StringNotEquals"
      values    = [
        "${aws_kms_key.S3-KMS-Key.arn}"
      ]
      variable  = "s3:x-amz-server-side-encryption-aws-kms-key-id"
    }
    effect    = "Deny"
    principals {
      identifiers = [
        "*"
      ]
      type        = "AWS"
    }
    resources = [
      "${aws_s3_bucket.S3.arn}",
      "${aws_s3_bucket.S3.arn}/*"
    ]
    sid       = "DenyIncorrectEncryptionHeader"
  }
  statement {
    actions   = [
      "s3:PutObject"
    ]
    condition {
      test      = "Null"
      values    = [
        "true"
      ]
      variable  = "s3:x-amz-server-side-encryption"
    }
    effect    = "Deny"
    principals {
      identifiers = [
        "*"
      ]
      type        = "AWS"
    }
    resources = [
      "${aws_s3_bucket.S3.arn}",
      "${aws_s3_bucket.S3.arn}/*"
    ]
    sid       = "DenyUnencryptedObjectUploads"
  }
}

resource "aws_s3_bucket" "S3" {
  bucket = "${var.prefix}-lambda-functions"
  acl    = "private"
  versioning {
    enabled = true
  }
    lifecycle_rule {
    id      = "expiry"
    enabled = true

    expiration {
       days = 180
    }
  }
  logging {
      target_bucket = "${var.log-bucket-id}"
          }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.S3-KMS-Key.arn
        sse_algorithm     = "aws:kms"
      }
}
}
}
resource "aws_s3_bucket_policy" "S3" {
  bucket = "${aws_s3_bucket.S3.id}"
  policy = "${data.aws_iam_policy_document.secure_bucket_policy.json}"
}
output "Key_arn" {
    value = "${aws_kms_key.S3-KMS-Key.arn}"
}

output "Bucket-ID" {
    value = "${aws_s3_bucket.S3.id}"
}
output "Bucket-ARN" {
    value = "${aws_s3_bucket.S3.arn}"
}
