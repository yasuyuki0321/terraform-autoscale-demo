resource "aws_security_group" "demo-alb" {
  name        = "demo-alb"
  description = "demo-alb"
  vpc_id      = aws_vpc.demo.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo-alb"
  }
}

resource "aws_security_group" "demo-web" {
  name        = "demo-web"
  description = "demo-web"
  vpc_id      = aws_vpc.demo.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.demo-alb.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["18.206.107.24/29"]
    # ec2-connect用のIP ※リージョン単位で異なる
    # https://aws.amazon.com/jp/premiumsupport/knowledge-center/ec2-instance-connect-troubleshooting/
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo-web"
  }
}
