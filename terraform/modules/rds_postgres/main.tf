resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-${var.env}-dbsubnet"
  subnet_ids = var.private_subnet_ids
}

resource "aws_db_instance" "this" {
  identifier             = "${var.project_name}-${var.env}-postgres"
  engine                 = "postgres"
  engine_version         = "16"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.sg_rds_id]

  username = var.db_username
  password = var.db_password

  publicly_accessible = false
  skip_final_snapshot = true

  multi_az                 = var.multi_az
  backup_retention_period  = 7
  backup_window            = "03:00-04:00"

  tags = { Name = "${var.project_name}-${var.env}-rds" }
}

output "endpoint" { value = aws_db_instance.this.address }
