## Role
resource "aws_iam_role" "ec2-demo-role" {
  name               = "ec2-demo-role"
  assume_role_policy = file("./policy/assume_role_policy.json")
}

# Instance Profile
resource "aws_iam_instance_profile" "ec2-demo-role" {
  name = "ec2-demo-role"
  role = aws_iam_role.ec2-demo-role.name
}

## Policy 
resource "aws_iam_policy" "ec2-connect" {
  name        = "ec2-connect"
  path        = "/"
  description = "ec2-connect"

  policy = file("./policy/ec2-connect.json")
}

# Role attachment
resource "aws_iam_role_policy_attachment" "ec2-demo-role" {
  role       = aws_iam_role.ec2-demo-role.name
  policy_arn = aws_iam_policy.ec2-connect.arn
}