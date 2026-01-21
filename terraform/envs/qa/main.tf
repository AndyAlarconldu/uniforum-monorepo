# ================================
# QA ENVIRONMENT
# ================================

module "network" {
  source = "../../modules/network"

  project_name = var.project_name
  env          = var.env

  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "security" {
  source = "../../modules/security"

  project_name = var.project_name
  env          = var.env

  vpc_id     = module.network.vpc_id
  my_ip_cidr = var.my_ip_cidr
}
