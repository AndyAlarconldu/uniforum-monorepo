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

variable "docker_identity_image" {
  type = string
}

variable "docker_user_image" {
  type = string
}
