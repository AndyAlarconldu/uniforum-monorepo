# =========================
# VARIABLES GENERALES
# =========================

variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

# =========================
# RED (NETWORK)
# =========================

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}

# =========================
# EC2
# =========================

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

# =========================
# DOCKER / MICROSERVICIOS
# =========================

variable "docker_identity_image" {
  type = string
}

variable "docker_user_image" {
  type = string
}
