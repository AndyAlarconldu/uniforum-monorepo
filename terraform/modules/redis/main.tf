resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.project_name}-${var.env}-redis-subnet"
  subnet_ids = var.private_subnet_ids
}

resource "aws_elasticache_cluster" "this" {
  cluster_id           = "${var.project_name}-${var.env}-redis"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.this.name
  security_group_ids   = [var.sg_redis_id]
}

output "endpoint" { value = aws_elasticache_cluster.this.cache_nodes[0].address }
