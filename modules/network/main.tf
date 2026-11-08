# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "irede-mvp-8-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "irede-mvp-8-igw"
  }
}

# Sub-rede Pública
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true

  tags = {
    Name = "irede-mvp-8-subnet-publica"
  }
}

# Sub-rede Privada 1
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = "irede-mvp-8-subnet-privada-1"
  }
}

# Sub-rede Privada 2
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = "irede-mvp-8-subnet-privada-2"
  }
}

# Tabela de Rotas Pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "irede-mvp-8-rt-publica"
  }
}

# Associação da sub-rede pública com a tabela de rotas pública
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Tabela de Rotas Privada
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  # Sem rota direta para IGW (seguindo restrição de custos)
  tags = {
    Name = "irede-mvp-8-rt-privada"
  }
}

# Associação da sub-rede privada 1 com a tabela de rotas privada
resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}

# Associação da sub-rede privada 2 com a tabela de rotas privada
resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id
}