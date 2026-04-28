# -----------------------------------------------
# IAM GROUPS
# -----------------------------------------------
resource "aws_iam_group" "calvin" {
  name = "Calvin"
}

resource "aws_iam_group" "osborne" {
  name = "Osborne"
}

# -----------------------------------------------
# IAM USERS
# -----------------------------------------------
resource "aws_iam_user" "userad" { name = "Userad" }
resource "aws_iam_user" "userbe" { name = "Userbe" }
resource "aws_iam_user" "userce" { name = "Userce" }
resource "aws_iam_user" "userde" { name = "Userde" }
resource "aws_iam_user" "usere"  { name = "Usere" }

# Admin user for daily operations (never use root)
resource "aws_iam_user" "adeyemi" {
  name = "Adeyemi"
  tags = {
    Role = "DailyAdmin"
  }
}

# -----------------------------------------------
# GROUP MEMBERSHIPS
# -----------------------------------------------
resource "aws_iam_group_membership" "calvin_members" {
  name  = "calvin-membership"
  group = aws_iam_group.calvin.name
  users = [
    aws_iam_user.userad.name,
    aws_iam_user.userbe.name,
  ]
}

resource "aws_iam_group_membership" "osborne_members" {
  name  = "osborne-membership"
  group = aws_iam_group.osborne.name
  users = [
    aws_iam_user.userce.name,
    aws_iam_user.userde.name,
    aws_iam_user.usere.name,
  ]
}

# -----------------------------------------------
# ADMIN POLICY ATTACHMENT (Adeyemi)
# -----------------------------------------------
resource "aws_iam_user_policy_attachment" "adeyemi_admin" {
  user       = aws_iam_user.adeyemi.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# -----------------------------------------------
# LEAST PRIVILEGE — DENY EC2 POLICY
# -----------------------------------------------
resource "aws_iam_policy" "deny_ec2" {
  name        = "ec2access"
  description = "Explicitly denies all EC2 actions — demonstrates Principle of Least Privilege"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Deny"
        Action   = "ec2:*"
        Resource = "*"
      }
    ]
  })
}
