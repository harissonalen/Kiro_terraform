# Projeto Infraestrutura MVP8 - Terraform

Infraestrutura como código (IaC) para provisionamento de recursos AWS utilizando Terraform.

---

## Arquitetura da Estrutura

```
Kiro_terraform/
│
├── modules/                    ← "O QUE" será criado (reutilizável)
│   ├── network/               ← Recursos de rede
│   │   ├── main.tf            → VPC, Subnets, IGW, Rotas
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── compute/               ← Recursos de compute (ECS)
│       ├── main.tf            → ECS Cluster, Task, Service,   ECR, IAM, SG
│       ├── variables.tf
│       └── outputs.tf
│
└── environments/              ← "COMO" será criado (por ambiente)
    ├── dev/                   ← Ambiente de desenvolvimento
    │   ├── main.tf            → Chama network + compute
    │   ├── variables.tf       → Valores específicos DEV
    │   ├── terraform.tfvars   → Configurações DEV
    │   ├── providers.tf       → Provider AWS (tags: env=dev)
    │   └── versions.tf
    │
    └── prod/                  ← Ambiente de produção
        ├── main.tf            → Chama network + compute
        ├── variables.tf       → Valores específicos PROD
        ├── terraform.tfvars   → Configurações PROD
        ├── providers.tf       → Provider AWS (tags: env=prod)
        └── versions.tf
```

---

## Recursos Criados

### Network (modules/network)
| Recurso | Descrição |
|---------|-----------|
| VPC | 10.0.0.0/16 (DEV) / 10.1.0.0/16 (PROD) |
| Internet Gateway | Acesso à internet |
| Subnet Pública | 10.0.1.0/24 (DEV) / 10.1.1.0/24 (PROD) |
| Subnet Privada 1 | 10.0.10.0/24 (DEV) / 10.1.10.0/24 (PROD) |
| Subnet Privada 2 | 10.0.20.0/24 (DEV) / 10.1.20.0/24 (PROD) |
| Route Tables | Pública e Privada |

### Compute (modules/compute)
| Recurso | Descrição |
|---------|-----------|
| ECS Cluster | Cluster Fargate |
| ECS Task Definition | Definição de tarefa |
| ECS Service | Serviço ECS |
| ECR Repository | Repositório de imagens Docker |
| IAM Role | Task Execution Role |
| Security Group | Controle de acesso |
| CloudWatch Log Group | Logs dos containers |

---

## Ambientes

| Configuração | DEV | PROD |
|--------------|-----|------|
| **Região** | us-west-1 | us-east-1 |
| **VPC CIDR** | 10.0.0.0/16 | 10.1.0.0/16 |
| **ECS CPU** | 256 vCPU | 512 vCPU |
| **ECS Memória** | 512 MB | 1024 MB |
| **ECS Tasks** | 1 | 2 |
| **State** | Isolado | Isolado |

---

## Tags Aplicadas

Todos os recursos recebem:
```
MVP         = "MVP8"
Project     = "Residencia-Cloud"
Environment = "dev" | "prod"
ManagedBy   = "Terraform"
```

---

## Quick Start

### 1. Configurar AWS
```powershell
aws configure
```

### 2. Inicializar ambiente
```powershell
# DEV
cd environments/dev
terraform init

# PROD
cd environments/prod
terraform init
```

### 3. Validar
```powershell
terraform validate
```

### 4. Verificar plano
```powershell
terraform plan
```

### 5. Aplicar (DEV apenas)
```powershell
terraform apply
```

---

## Fluxo de Execução

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  Usuário    │ ──▶ │  Ambiente   │ ──▶ │  Módulos    │
│  (terraform │     │  (dev/prod) │     │  (network + │
│   apply)    │     │             │     │   compute)  │
└─────────────┘     └─────────────┘     └─────────────┘
```

---

## Boas Práticas

- ✅ Sempre rode `terraform validate` antes de `apply`
- ✅ Use `terraform plan` para revisar mudanças
- ✅ Mantenha `.terraform.lock.hcl` no git
- ✅ **NUNCA** commite arquivos `.tfstate` ou `.tfvars` com valores reais
- ✅ Cada ambiente tem seu próprio state (isolamento)

---

## Estrutura Ignorada (.gitignore)

Consulte `.gitignore` para ver arquivos não versionados:
- Estados do Terraform (*.tfstate)
- Arquivos de plano (*.tfplan)
- Credenciais (*.pem, *.key, *.csv)
- Variáveis com valores reais (*.tfvars)

---

## Dúvidas Frequentes

**P: Preciso criar os dois ambientes de uma vez?**
R: Não. Cada ambiente é independente.

**P: Como mudar valores de um ambiente?**
R: Edite o arquivo `terraform.tfvars` do ambiente desejado.

**P: PROD faz deploy?**
R: O código está pronto. Execute conforme necessidade.

---

## Suporte

Em caso de dúvidas:
1. Verifique credenciais AWS (`aws configure`)
2. Confirme Terraform >= 1.0 instalado
3. Verifique permissões IAM