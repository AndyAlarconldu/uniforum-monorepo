# ===============================
# Proyecto
# ===============================
project_name = "uniforum"
env          = "qa"
aws_region   = "us-east-1"

# ===============================
# Red
# ===============================
vpc_cidr = "10.10.0.0/16"

azs = [
  "us-east-1a",
  "us-east-1b"
]

public_subnet_cidrs = [
  "10.10.1.0/24",
  "10.10.2.0/24"
]

private_subnet_cidrs = [
  "10.10.11.0/24",
  "10.10.12.0/24"
]

# ===============================
# Seguridad
# ⚠️ CAMBIA ESTA IP POR LA TUYA REAL
# ejemplo válido:
# https://whatismyipaddress.com
# ===============================
my_ip_cidr = "190.152.34.56/32"

# ===============================
# EC2
# ===============================
key_name      = "uniforum-key"
instance_type = "t2.micro" # para académico está PERFECTO

# ===============================
# Base de datos
# ===============================
db_username = "uniforumadmin"
db_password = "Uniforum123!" # solo para QA / académico

# ===============================
# DockerHub
# ===============================
dockerhub_user = "andyxalarcon"
dockerhub_tag  = "qa"
