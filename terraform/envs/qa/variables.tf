variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.medium"
}

variable "docker_images" {
  description = "Docker images for all microservices"
  type        = map(string)
}
