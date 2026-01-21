resource "aws_launch_template" "this" {
  name_prefix   = "${var.project_name}-${var.env}-lt"
  image_id      = "ami-0c02fb55956c7d316" # Amazon Linux 2 (FIJO, permitido)
  instance_type = var.instance_type

  user_data = base64encode(templatefile(
    "${path.module}/user_data.sh",
    {
      IDENTITY_IMAGE = var.docker_identity_image
      USER_IMAGE     = var.docker_user_image
    }
  ))

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.security_group_id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.project_name}-${var.env}-qa"
      Environment = var.env
    }
  }
}

resource "aws_autoscaling_group" "this" {
  desired_capacity = 1
  min_size         = 1
  max_size         = 1

  vpc_zone_identifier = var.public_subnet_ids
  target_group_arns  = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
}
