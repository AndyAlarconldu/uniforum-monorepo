module "network" {
  source = "../../modules/network"
}

module "security" {
  source = "../../modules/security"

  project_name = var.project_name
  env          = var.env
  vpc_id       = module.network.vpc_id
}

module "alb" {
  source = "../../modules/alb"

  project_name      = var.project_name
  env               = var.env
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  security_group_id = module.security.sg_id
}

module "asg_app" {
  source = "../../modules/asg_app"

  project_name          = var.project_name
  env                   = var.env
  instance_type         = var.instance_type
  public_subnet_ids     = module.network.public_subnet_ids
  security_group_id     = module.security.sg_id
  target_group_arn      = module.alb.target_group_arn
  docker_images     = var.docker_images
}
