output "vpc_id" {
  description = "ID da VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Bloco CIDR da VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_id" {
  description = "ID da sub-rede pública"
  value       = aws_subnet.public.id
}

output "private_subnet_1_id" {
  description = "ID da sub-rede privada 1"
  value       = aws_subnet.private_1.id
}

output "private_subnet_2_id" {
  description = "ID da sub-rede privada 2"
  value       = aws_subnet.private_2.id
}

output "internet_gateway_id" {
  description = "ID do Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "public_route_table_id" {
  description = "ID da tabela de rotas pública"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID da tabela de rotas privada"
  value       = aws_route_table.private.id
}