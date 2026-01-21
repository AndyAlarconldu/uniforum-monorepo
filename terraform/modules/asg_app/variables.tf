# Nombre del proyecto (uniforum)
variable "project_name" {
  type = string
}

# Entorno: qa o prod
variable "env" {
  type = string
}

# Tipo de instancia EC2
variable "instance_type" {
  type = string
}

# Subnets públicas donde se crea la EC2
variable "public_subnet_ids" {
  type = list(string)
}

# Security Group de la aplicación
variable "security_group_id" {
  type = string
}

# Target Group del ALB
variable "target_group_arn" {
  type = string
}

# Imagen Docker del microservicio identity
variable "docker_identity_image" {
  type = string
}

# Imagen Docker del microservicio user
variable "docker_user_image" {
  type = string
}
