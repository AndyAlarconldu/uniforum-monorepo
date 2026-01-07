variable "project_name" { type = string }
variable "env" { type = string }

variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "sg_app_id" { type = string }

variable "key_name" { type = string }
variable "instance_type" { type = string }

variable "target_group_arn" { type = string }

variable "dockerhub_user" { type = string }
variable "dockerhub_tag" { type = string }
