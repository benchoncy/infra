resource "aws_iam_user" "obsidian_user" {
  name = "obsidian"
  path = "/app/"
}

resource "aws_iam_access_key" "obsidian_user_key" {
  user = aws_iam_user.obsidian_user.name
}

resource "onepassword_item" "aws_obsidian_user" {
  vault = data.onepassword_vault.automation.uuid

  title    = "AWS Obsidian User"
  category = "login"

  username = aws_iam_user.obsidian_user.name
  section {
    label = "Access Key"
    field {
      label = "Access Key ID"
      value = aws_iam_access_key.obsidian_user_key.id
    }
    field {
      label = "Secret Access Key"
      value = aws_iam_access_key.obsidian_user_key.secret
      type  = "CONCEALED"
    }
  }

  tags = ["ManagedBy:OpenTofu"]
}

resource "aws_s3_bucket" "obsidian_sync" {
  bucket = "bstuart-obsidian-sync"
}

data "aws_iam_policy_document" "obsidian_sync_policy" {
  statement {
    actions = [
      "s3:List*",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject"
    ]
    resources = [
      aws_s3_bucket.obsidian_sync.arn,
      "${aws_s3_bucket.obsidian_sync.arn}/*",
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.obsidian_user.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "obsidian_policy" {
  bucket = aws_s3_bucket.obsidian_sync.id
  policy = data.aws_iam_policy_document.obsidian_sync_policy.json
}
