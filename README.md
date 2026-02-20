# infrastructure-execution-service-db

## Terraform (MongoDB Atlas)

Infra em `terraform/atlas` cria:

- Project no MongoDB Atlas
- Cluster (AWS)
- IP access list
- Database user com role `readWrite` no database `execution-service-db`

### Pré-requisitos

- Terraform >= 1.5
- Conta no MongoDB Atlas
- Atlas API Keys (Public/Private)
- Atlas Org ID

### Aplicar

1. Copie o arquivo `terraform.tfvars.example` para `terraform.tfvars` em `terraform/atlas` e preencha os valores:

```hcl
mongodb_atlas_public_key  = "..."
mongodb_atlas_private_key = "..."
mongodb_atlas_org_id      = "..."

# opcional
mongodb_atlas_project_name  = "execution-service"
mongodb_atlas_cluster_name  = "execution-service-cluster"
mongodb_atlas_aws_region    = "US_EAST_1"
mongodb_atlas_instance_size = "M10"

# importante: restringir para seu IP/CIDR se possível
mongodb_atlas_allow_cidr = "0.0.0.0/0"

mongodb_database             = "execution-service-db"
mongo_seed_default_password  = "abc123"
mongodb_atlas_db_username    = "execution_service"
```

2. Rode:

```bash
terraform -chdir=terraform/atlas init
terraform -chdir=terraform/atlas apply
```

### Seed inicial

O seed inicial do banco é executado pela aplicação via Job no Kubernetes.

## CI/CD (GitHub Actions)

Workflows em `.github/workflows`:

- `terraform-validate.yml`: roda em PRs com target `develop` (fmt/validate/plan)
- `terraform-deploy.yml`: roda quando um PR para `main` é fechado e **mergeado** (apply)

### Secrets necessários (GitHub)

Configure em `Settings > Secrets and variables > Actions`:

- `MONGODB_ATLAS_PUBLIC_KEY`
- `MONGODB_ATLAS_PRIVATE_KEY`
- `MONGODB_ATLAS_ORG_ID`

Para deploy (apply), também:

- `MONGODB_ATLAS_ALLOW_CIDR` (ex.: seu IP/CIDR)