variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}



# Borra el bloque viejo de "docker_images" y pega este:
variable "docker_images" {
  description = "Mapa de imágenes Docker"
  type        = map(string)
}