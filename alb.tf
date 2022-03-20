## ALB
resource "aws_lb" "demo" {
  load_balancer_type = "application"
  name               = "demo"

  security_groups = [aws_security_group.demo-alb.id]
  subnets         = [aws_subnet.public-a.id, aws_subnet.public-c.id]
}

## TargetGroup
resource "aws_lb_target_group" "demo" {
  name     = "demo-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.demo.id

  deregistration_delay = 10
  health_check {
    interval = 10
  }
}

## Listener
resource "aws_lb_listener" "demo" {
  port              = "80"
  protocol          = "HTTP"
  load_balancer_arn = aws_lb.demo.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo.arn
  }
}

## Attach EC2
# resource "aws_lb_target_group_attachment" "demo" {
#   count            = length(aws_instance.demo)
#   target_group_arn = aws_lb_target_group.demo.arn
#   target_id        = element(aws_instance.demo, count.index).id
#   port             = 80
# }
