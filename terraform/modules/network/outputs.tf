output "vpc_id" {
  value = data.aws_vpc.this.id
}

output "public_subnet_ids" {
  value = data.aws_subnets.public.ids
}
