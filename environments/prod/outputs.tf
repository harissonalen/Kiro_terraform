# Outputs do ambiente PROD

# Network outputs
output "vpc_id" {
  description = "ID da VPC do ambiente PROD"
  value       = module.network.vpc_id
}

output "vpc_cidr" {
  description = "Bloco CIDR da VPC"
  value       = module.network.vpc_cidr
}

output "public_subnet_id" {
  description = "ID da sub-rede pública"
  value       = module.network.public_subnet_id
}

output "private_subnet_1_id" {
  description = "ID da sub-rede privada 1"
  value       = module.network.private_subnet_1_id
}

output "private_subnet_2_id" {
  description = "ID da sub-rede privada 2"
  value       = module.network.private_subnet_2_id
}

# Compute outputs
output "ecs_cluster_arn" {
  description = "ARN do Cluster ECS"
  value       = module.compute.ecs_cluster_arn
}

output "ecs_cluster_name" {
  description = "Nome do Cluster ECS"
  value       = module.compute.ecs_cluster_name
}

output "ecs_service_name" {
  description = "Nome do Serviço ECS"
  value       = module.compute.ecs_service_name
}

output "ecr_repository_url" {
  description = "URL do Repositório ECR"
  value       = module.compute.ecr_repository_url
}

output "security_group_id" {
  description = "ID do Security Group"
  value       = module.compute.security_group_id
}