module "network" {
  source = "../../modules/network"

  project_name         = var.project_name
  env                  = var.env
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}

module "security" {
  source = "../../modules/security"

  project_name = var.project_name
  env          = var.env
  vpc_id       = module.network.vpc_id
  my_ip_cidr   = var.my_ip_cidr
}

module "bastion" {
  source = "../../modules/bastion"

  project_name     = var.project_name
  env              = var.env
  public_subnet_id = module.network.public_subnet_ids[0]
  sg_bastion_id    = module.security.sg_bastion_id
  key_name         = var.key_name
}

module "rds" {
  source = "../../modules/rds_postgres"

  project_name       = var.project_name
  env                = var.env
  private_subnet_ids = module.network.private_subnet_ids
  sg_rds_id          = module.security.sg_rds_id

  db_username = var.db_username
  db_password = var.db_password

  multi_az = false
}

module "redis" {
  source = "../../modules/redis"

  project_name       = var.project_name
  env                = var.env
  private_subnet_ids = module.network.private_subnet_ids
  sg_redis_id        = module.security.sg_redis_id
}

module "alb" {
  source = "../../modules/alb"

  project_name      = var.project_name
  env               = var.env
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  sg_alb_id         = module.security.sg_alb_id
}

module "asg_app" {
  source = "../../modules/asg_app"

  project_name = var.project_name
  env          = var.env

  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  sg_app_id          = module.security.sg_app_id

  key_name      = var.key_name
  instance_type = var.instance_type

  target_group_arn = module.alb.target_group_arn

  dockerhub_user = var.dockerhub_user
  dockerhub_tag  = var.dockerhub_tag
}

# ✅ API Gateway (opcional)
module "api_gateway" {
  source = "../../modules/api_gateway"

  project_name = var.project_name
  env          = var.env

  # ✅ lo más común: API Gateway HTTP proxy hacia ALB usando el DNS
  alb_dns_name = module.alb.alb_dns_name
}
