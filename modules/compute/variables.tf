# Variáveis reutilizáveis para Compute
# Os ambientes definirão valores específicos ao chamar este módulo

variable "aws_region" {
  description = "Região AWS"
  type        = string
}

variable "environment" {
  description = "Ambiente (dev, prod)"
  type        = string
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "irede-mvp-8"
}

variable "vpc_id" {
  description = "ID da VPC onde os recursos serão criados"
  type        = string
}

variable "public_subnet_id" {
  description = "ID da sub-rede pública"
  type        = string
}

variable "private_subnet_1_id" {
  description = "ID da sub-rede privada 1"
  type        = string
}

variable "private_subnet_2_id" {
  description = "ID da sub-rede privada 2"
  type        = string
}

# Parâmetros de configuração do ECS
variable "cpu" {
  description = "CPU units para a tarefa ECS (ex: 256, 512, 1024)"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memória em MB para a tarefa ECS (ex: 512, 1024, 2048)"
  type        = number
  default     = 512
}

variable "task_count" {
  description = "Quantidade de tarefas do serviço ECS"
  type        = number
  default     = 1
}

variable "container_port" {
  description = "Porta do container"
  type        = number
  default     = 80
}

variable "ecr_image_tag" {
  description = "Tag da imagem no ECR"
  type        = string
  default     = "latest"
}