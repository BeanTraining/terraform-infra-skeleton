output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_default_security_group_id" {
  value = module.vpc.default_security_group_id
}

output "vpc_private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "vpc_public_subnet_ids" {
  value = module.vpc.public_subnets
}

