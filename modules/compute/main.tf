# ============================================
# MÓDULO DE COMPUTE - ECS Fargate
# Reutilizável por todos os ambientes
# ============================================

# --------------------------------------------
# CloudWatch Log Group
# --------------------------------------------
resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${var.project_name}-${var.environment}"
  retention_in_days = 7

  tags = {
    Name        = "irede-mvp-8-log-group"
    Environment = var.environment
  }
}

# --------------------------------------------
# ECR - Elastic Container Registry
# --------------------------------------------
resource "aws_ecr_repository" "main" {
  name = "${var.project_name}-${var.environment}"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "irede-mvp-8-ecr"
    Environment = var.environment
  }
}

# --------------------------------------------
# IAM - Task Execution Role
# --------------------------------------------
resource "aws_iam_role" "ecs_task_execution" {
  name = "irede-mvp-8-ecs-task-execution-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  tags = {
    Name        = "irede-mvp-8-iam-role"
    Environment = var.environment
  }
}

# Política de execução de tarefa ECS
resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# --------------------------------------------
# Security Group
# --------------------------------------------
resource "aws_security_group" "ecs" {
  name        = "irede-mvp-8-ecs-sg-${var.environment}"
  description = "Security Group para ECS - ${var.environment}"
  vpc_id      = var.vpc_id

  # regra será configurada pelos ambientes conforme necessidade
  ingress {
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name        = "irede-mvp-8-sg"
    Environment = var.environment
  }
}

# --------------------------------------------
# ECS Cluster
# --------------------------------------------
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-${var.environment}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name        = "irede-mvp-8-ecs-cluster"
    Environment = var.environment
  }
}

# --------------------------------------------
# ECS Task Definition
# --------------------------------------------
resource "aws_ecs_task_definition" "main" {
  family                   = "${var.project_name}-${var.environment}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "${var.project_name}-container"
      image     = "${aws_ecr_repository.main.repository_url}:${var.ecr_image_tag}"
      cpu       = var.cpu
      memory    = var.memory
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])

  tags = {
    Name        = "irede-mvp-8-task-def"
    Environment = var.environment
  }
}

# --------------------------------------------
# ECS Service
# --------------------------------------------
resource "aws_ecs_service" "main" {
  name            = "${var.project_name}-${var.environment}"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = var.task_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.private_subnet_1_id, var.private_subnet_2_id]
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = false
  }

  tags = {
    Name        = "irede-mvp-8-ecs-service"
    Environment = var.environment
  }
}