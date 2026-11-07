# Variáveis específicas do ambiente DEV

variable "aws_region" {
  description = "Região AWS para o ambiente DEV"
  type        = string
  default     = "us-west-1"
}

variable "vpc_cidr" {
  description = "Bloco CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Bloco CIDR da sub-rede pública"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_1_cidr" {
  description = "Bloco CIDR da sub-rede privada 1"
  type        = string
  default     = "10.0.10.0/24"
}

variable "private_subnet_2_cidr" {
  description = "Bloco CIDR da sub-rede privada 2"
  type        = string
  default     = "10.0.20.0/24"
}

variable "availability_zone_1" {
  description = "Zona de disponibilidade 1"
  type        = string
  default     = "us-west-1a"
}

variable "availability_zone_2" {
  description = "Zona de disponibilidade 2"
  type        = string
  default     = "us-west-1c"
}

# Variáveis do ECS Compute
variable "ecs_cpu" {
  description = "CPU para tarefa ECS"
  type        = number
  default     = 256
}

variable "ecs_memory" {
  description = "Memória para tarefa ECS (MB)"
  type        = number
  default     = 512
}

variable "ecs_task_count" {
  description = "Quantidade de tarefas ECS"
  type        = number
  default     = 1
}

variable "container_port" {
  description = "Porta do container"
  type        = number
  default     = 80
}

variable "ecr_image_tag" {
  description = "Tag da imagem ECR"
  type        = string
  default     = "latest"
}