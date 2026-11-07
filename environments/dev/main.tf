# Chamada do módulo Network
module "network" {
  source = "../../modules/network"

  # Parâmetros de rede específicos do ambiente DEV
  aws_region           = var.aws_region
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  availability_zone_1  = var.availability_zone_1
  availability_zone_2  = var.availability_zone_2
}

# Chamada do módulo Compute
module "compute" {
  source = "../../modules/compute"

  # Parâmetros específicos do ambiente DEV
  environment         = "dev"
  project_name        = "irede-mvp-8"
  aws_region          = var.aws_region
  vpc_id              = module.network.vpc_id
  public_subnet_id    = module.network.public_subnet_id
  private_subnet_1_id = module.network.private_subnet_1_id
  private_subnet_2_id = module.network.private_subnet_2_id
  cpu                 = var.ecs_cpu
  memory              = var.ecs_memory
  task_count          = var.ecs_task_count
  container_port      = var.container_port
  ecr_image_tag       = var.ecr_image_tag
}