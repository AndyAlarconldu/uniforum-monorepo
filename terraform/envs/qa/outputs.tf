output "alb_dns" { value = module.alb.alb_dns_name }
output "api_gateway" { value = module.api_gateway.invoke_url }
output "bastion_ip" { value = module.bastion.public_ip }
output "rds_endpoint" { value = module.rds.endpoint }
output "redis_endpoint" { value = module.redis.endpoint }
