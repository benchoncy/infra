resource "aws_iam_user" "truenas_user" {
  name = "truenas"
  path = "/ops/"
}

data "aws_iam_policy_document" "truenas_user" {
  statement {
    actions = [
      "s3:ListAllMyBuckets",
    ]
    resources = ["arn:aws:s3:::*"]
  }
}

resource "aws_iam_user_policy" "truenas_user_policy" {
  name   = "truenas-user-policy"
  user   = aws_iam_user.truenas_user.name
  policy = data.aws_iam_policy_document.truenas_user.json
}

resource "aws_iam_access_key" "truenas_user_key" {
  user = aws_iam_user.truenas_user.name
}

resource "onepassword_item" "aws_truenas_user" {
  vault = data.onepassword_vault.automation.uuid

  title    = "AWS TrueNAS User"
  category = "login"

  username = aws_iam_user.truenas_user.name
  section {
    label = "Access Key"
    field {
      label = "Access Key ID"
      value = aws_iam_access_key.truenas_user_key.id
    }
    field {
      label = "Secret Access Key"
      value = aws_iam_access_key.truenas_user_key.secret
      type  = "CONCEALED"
    }
  }

  tags = ["ManagedBy:OpenTofu"]
}

resource "aws_s3_bucket" "backups" {
  bucket = "bstuart-backups"
}

data "aws_iam_policy_document" "backups_policy" {
  statement {
    actions = [
      "s3:List*",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject"
    ]
    resources = [
      aws_s3_bucket.backups.arn,
      "${aws_s3_bucket.backups.arn}/*",
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.truenas_user.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "backups_policy" {
  bucket = aws_s3_bucket.backups.id
  policy = data.aws_iam_policy_document.backups_policy.json
}
