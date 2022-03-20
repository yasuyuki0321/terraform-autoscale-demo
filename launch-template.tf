## LaunchTemplate
resource "aws_launch_template" "demo" {
  name_prefix   = "demo"
  image_id      = data.aws_ami.latest-amazon-linux2.image_id
  instance_type = "t3.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.demo-web.id]
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2-demo-role.arn
  }

  user_data = filebase64("./user_data/ec2-demo.sh")
}
