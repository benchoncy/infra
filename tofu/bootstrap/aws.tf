resource "aws_iam_user" "automation_user" {
  name = "automation"
  path = "/ops/"
}

resource "aws_iam_access_key" "automation_user_key" {
  user = aws_iam_user.automation_user.name
}

resource "aws_iam_user_group_membership" "automation_user_membership" {
  user = aws_iam_user.automation_user.name

  groups = [
    aws_iam_group.admin.name,
  ]
}

resource "aws_iam_group" "admin" {
  name = "admin"
  path = "/ops/"
}

resource "aws_iam_group_policy_attachment" "admin_attach" {
  group      = aws_iam_group.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "onepassword_item" "aws_automation_user" {
  vault = data.onepassword_vault.automation.uuid

  title    = "AWS Automation User"
  category = "login"

  username = aws_iam_user.automation_user.name
  section {
    label = "Access Key"
    field {
      label = "Access Key ID"
      value = aws_iam_access_key.automation_user_key.id
    }
    field {
      label = "Secret Access Key"
      value = aws_iam_access_key.automation_user_key.secret
      type  = "CONCEALED"
    }
  }

  tags = ["ManagedBy:OpenTofu"]
}
