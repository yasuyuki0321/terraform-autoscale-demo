## AutoScaligGroup
resource "aws_autoscaling_group" "demo" {
  name_prefix               = "demo"
  desired_capacity          = 2
  max_size                  = 4
  min_size                  = 1
  health_check_grace_period = 300

  health_check_type = "ELB"
  target_group_arns = [aws_lb_target_group.demo.arn]

  vpc_zone_identifier = [aws_subnet.private-a.id, aws_subnet.private-c.id]

  launch_template {
    id      = aws_launch_template.demo.id
    version = "$Latest"
  }
}

## AutoscalingPolicy
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "demo_scale_up"
  autoscaling_group_name = aws_autoscaling_group.demo.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 60
}

resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_description   = "Monitors CPU utilization for demo ASG"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
  alarm_name          = "demo_scale_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "50"
  evaluation_periods  = "1"
  period              = "60"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.demo.name
  }
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "demo_scale_down"
  autoscaling_group_name = aws_autoscaling_group.demo.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 60
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_description   = "Monitors CPU utilization for demo ASG"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  alarm_name          = "demo_scale_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "25"
  evaluation_periods  = "1"
  period              = "60"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.demo.name
  }
}