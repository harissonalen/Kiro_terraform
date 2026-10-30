# Rede VPC - MVP8

Projeto Terraform para provisionar camada de rede na AWS.

## Arquitetura

- 1 VPC (10.0.0.0/16)
- 1 Sub-rede Publica (10.0.1.0/24)
- 2 Sub-redes Privadas (10.0.10.0/24, 10.0.20.0/24)
- 1 Internet Gateway
- 1 Tabela de Rotas Publica (0.0.0.0/0 -> IGW)
- 1 Tabela de Rotas Privada

## Estrutura de Arquivos

- versions.tf - Configuracao Terraform e Provider
- providers.tf - Provider AWS
- variables.tf - Variaveis
- main.tf - Recursos de rede
- outputs.tf - Outputs
- dev.tfvars - Variaveis dev
- staging.tfvars - Variaveis staging
- README.md - Este arquivo

## Pre-requisitos

1. Terraform instalado (versao >= 1.0)
2. AWS CLI configurado

## Configuracao AWS CLI

`powershell
aws configure
`

## Comandos de Uso

### Inicializacao
terraform init

### Formatacao
terraform fmt

### Validacao
terraform validate

### Criar Workspace (primeira vez)
terraform workspace new dev
terraform workspace new staging

### Plan
terraform plan -var-file="dev.tfvars" -out="dev.tfplan"
terraform plan -var-file="staging.tfvars" -out="staging.tfplan"

### Apply
terraform apply "dev.tfplan"
terraform apply "staging.tfplan"

### Destroy
terraform plan -var-file="dev.tfvars" -out="dev.tfplan" -destroy
terraform apply "dev.tfplan"
terraform plan -var-file="staging.tfvars" -out="staging.tfplan" -destroy
terraform apply "staging.tfplan"

## Comandos Uteis

terraform workspace show
terraform workspace list
terraform workspace select dev
terraform workspace select staging
