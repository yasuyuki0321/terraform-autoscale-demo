data "aws_ami" "latest-amazon-linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "state"
    values = ["available"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*"]
  }
}