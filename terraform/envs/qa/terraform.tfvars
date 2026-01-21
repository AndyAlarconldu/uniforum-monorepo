# Proyecto
project_name = "uniforum"
env          = "qa"
aws_region   = "us-east-1"

# Red
vpc_cidr = "10.0.0.0/16"

azs = ["us-east-1a", "us-east-1b"]

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]

# Seguridad
my_ip_cidr = "45.162.74.25/32"

# EC2
key_name = "uniforum-key"

# DockerHub
dockerhub_user = "tu_usuario_dockerhub"
dockerhub_tag  = "qa"

# Base de datos
db_username = "uniforum"
db_password = "uniforum123"
