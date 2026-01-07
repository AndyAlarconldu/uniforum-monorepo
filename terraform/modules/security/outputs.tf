output "sg_alb_id" {
  value = aws_security_group.alb.id
}

output "sg_bastion_id" {
  value = aws_security_group.bastion.id
}

output "sg_app_id" {
  value = aws_security_group.app.id
}

output "sg_rds_id" {
  value = aws_security_group.rds.id
}

output "sg_redis_id" {
  value = aws_security_group.redis.id
}
