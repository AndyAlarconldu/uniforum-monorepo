variable "project_name" { type = string }
variable "env" { type = string }
variable "aws_region" { type = string }

variable "vpc_cidr" { type = string }
variable "azs" { type = list(string) }
variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }

variable "my_ip_cidr" { type = string } # TU IP PUBLICA /32
variable "key_name" { type = string }

variable "db_username" { type = string }
variable "db_password" {
  type      = string
  sensitive = true
}


variable "dockerhub_user" { type = string }
variable "dockerhub_tag" { type = string } # qa o prod

# instancias app
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
