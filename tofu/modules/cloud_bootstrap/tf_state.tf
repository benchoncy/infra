resource "aws_s3_bucket" "tf_state" {
  bucket = "bstuart-tf-state"

  tags = {
    Name = "tf-state"
  }
}

resource "aws_s3_bucket_acl" "tf_state_acl" {
  bucket = aws_s3_bucket.tf_state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "tf_state_lifecycle" {
  depends_on = [aws_s3_bucket_versioning.tf_state_versioning]

  bucket = aws_s3_bucket.tf_state.id

  rule {
    id     = "old-tf-state"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 30
    }

  }

  rule {
    id     = "deletion-markers"
    status = "Enabled"

    expiration {
      expired_object_delete_marker = true
    }
  }
}

resource "aws_dynamodb_table" "tf_state_lock" {
  name         = "tf-state-locking-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "tf-state-locking-table"
  }
}
