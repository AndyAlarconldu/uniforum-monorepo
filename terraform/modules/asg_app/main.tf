resource "aws_launch_template" "this" {
  name_prefix   = "${var.project_name}-${var.env}-lt-"
  image_id      = data.aws_ami.amzn2.id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.sg_app_id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install docker -y
    systemctl start docker
    systemctl enable docker
    usermod -aG docker ec2-user

    docker pull andyxalarcon/uniforum-frontend:qa
    docker run -d --restart=always -p 80:80 andyxalarcon/uniforum-frontend:qa
  EOF
  )



  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-${var.env}-app"
    }
  }
}

data "aws_ami" "amzn2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_autoscaling_group" "this" {
  name                = "${var.project_name}-${var.env}-asg"
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  vpc_zone_identifier = var.private_subnet_ids

  health_check_type         = "ELB"
  health_check_grace_period = 120

  target_group_arns = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.env}-asg"
    propagate_at_launch = true
  }
}
