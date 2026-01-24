resource "aws_launch_template" "this" {
  name_prefix   = "${var.project_name}-${var.env}-lt"
  image_id      = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type = var.instance_type

  user_data = base64encode(templatefile(
  "${path.module}/user_data.sh",
  {
    IDENTITY     = var.docker_images["identity"]
    USER         = var.docker_images["user"]
    FORUM        = var.docker_images["forum"]
    POST         = var.docker_images["post"]
    REPLY        = var.docker_images["reply"]
    ACADEMIC     = var.docker_images["academic"]
    REACTION     = var.docker_images["reaction"]
    SEARCH       = var.docker_images["search"]
    NOTIFICATION = var.docker_images["notification"]
    MODERATION   = var.docker_images["moderation"]
  }
))


  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.security_group_id]
  }
}

resource "aws_autoscaling_group" "this" {
  desired_capacity = 1
  min_size         = 1
  max_size         = 3

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
}
