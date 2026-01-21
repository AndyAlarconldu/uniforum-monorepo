project_name = "uniforum"
env          = "qa"
aws_region   = "us-east-1"

vpc_cidr = "10.0.0.0/16"

azs = ["us-east-1a"]

public_subnet_cidrs  = ["10.0.1.0/24"]
private_subnet_cidrs = ["10.0.2.0/24"]

my_ip_cidr = "0.0.0.0/0"
key_name   = "uniforum-key"

db_username = "dummy"
db_password = "dummy123"
