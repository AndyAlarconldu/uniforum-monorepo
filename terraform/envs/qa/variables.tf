variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "docker_identity_image" {
  type = string
}

variable "docker_user_image" {
  type = string
}
