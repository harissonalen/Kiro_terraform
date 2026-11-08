# Outputs do módulo de Compute

output "ecs_cluster_arn" {
  description = "ARN do Cluster ECS"
  value       = aws_ecs_cluster.main.arn
}

output "ecs_cluster_name" {
  description = "Nome do Cluster ECS"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "Nome do Serviço ECS"
  value       = aws_ecs_service.main.name
}

output "ecr_repository_url" {
  description = "URL do Repositório ECR"
  value       = aws_ecr_repository.main.repository_url
}

output "ecr_repository_arn" {
  description = "ARN do Repositório ECR"
  value       = aws_ecr_repository.main.arn
}

output "security_group_id" {
  description = "ID do Security Group"
  value       = aws_security_group.ecs.id
}

output "task_execution_role_arn" {
  description = "ARN da Role de Execução de Tarefas"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "cloudwatch_log_group_name" {
  description = "Nome do Grupo de Logs CloudWatch"
  value       = aws_cloudwatch_log_group.ecs.name
}