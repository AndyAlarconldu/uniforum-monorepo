

resource "aws_launch_template" "this" {
  name_prefix   = "${var.project_name}-${var.env}-lt"
  image_id      = "ami-0c02fb55956c7d316"
  instance_type = var.instance_type

  user_data = base64encode(file("${path.module}/user_data.sh"))

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.security_group_id]
  }
}

resource "aws_autoscaling_group" "this" {
  desired_capacity = 1
  min_size         = 1
  max_size         = 2

  vpc_zone_identifier = var.public_subnet_ids
  target_group_arns  = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.env}-app"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.env
    propagate_at_launch = true
  }

}


  

