# PROYECTO2-TERRAFORM

Infraestructura como Código (IaC) para desplegar una VPC, ALB y Auto Scaling Group en AWS utilizando Terraform. Este proyecto está modularizado para facilitar la reutilización y el mantenimiento, con soporte para múltiples entornos (actualmente DEV).

## 📋 Tabla de Contenidos

- [Descripción](#descripción)
- [Arquitectura](#arquitectura)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Requisitos Previos](#requisitos-previos)
- [Instalación y Configuración](#instalación-y-configuración)
- [Uso](#uso)
- [Variables](#variables)
- [Outputs](#outputs)
- [Contribución](#contribución)
- [Licencia](#licencia)

## 📖 Descripción

Este proyecto define una infraestructura completa en AWS que incluye:
- **VPC**: Red privada virtual con subnets públicas y privadas, Internet Gateway y NAT Gateway.
- **ALB (Application Load Balancer)**: Balanceador de carga para distribuir tráfico a instancias EC2.
- **Auto Scaling Group**: Grupo de escalado automático con Launch Template para instancias EC2.

Está diseñado para entornos separados y utiliza salidas de módulos para enlazar componentes de manera eficiente.

## 🏗️ Arquitectura

```
AWS Cloud
├── VPC (10.0.0.0/16)
│   ├── Subnets Públicas (us-east-1a, us-east-1b)
│   │   ├── Internet Gateway
│   │   └── ALB
│   └── Subnets Privadas (us-east-1a, us-east-1b)
│       ├── NAT Gateway
│       └── Auto Scaling Group (EC2 instances)
```

## 📁 Estructura del Proyecto

```
PROYECTO2-TERRAFORM/
├── provider.tf                 # Configuración del proveedor AWS
├── README.md                   # Este archivo
├── BACKEND/                    # Configuración de backend (si aplica)
├── BOOTSTRAP/                  # Scripts de inicialización
├── MODULES/                    # Módulos reutilizables
│   ├── VPC/                    # Módulo de red/VPC
│   │   ├── vpc.tf              # Definición de VPC
│   │   ├── igw.tf              # Internet Gateway
│   │   ├── natgateway.tf       # NAT Gateway
│   │   ├── subnets.tf          # Subnets públicas y privadas
│   │   ├── routes.tf           # Tablas de rutas
│   │   ├── locals.tf           # Variables locales
│   │   ├── variables.tf        # Variables de entrada
│   │   └── outputs.tf          # Salidas del módulo
│   └── ALB_AUTOSCALING/        # Módulo de aplicación
│       ├── alb.tf              # Application Load Balancer
│       ├── autoscaling.tf      # Auto Scaling Group
│       ├── launch_template.tf  # Plantilla de lanzamiento
│       ├── security_groups.tf  # Grupos de seguridad
│       ├── politica_escalado.tf # Políticas de escalado
│       ├── variables.tf        # Variables de entrada
│       ├── outputs.tf          # Salidas del módulo
│       └── USERDATA/           # Scripts de usuario
│           └── user_data.sh.tpl
├── ENVIROMENT/                 # Entornos específicos
│   └── DEV/                    # Entorno de desarrollo
│       ├── main.tf             # Configuración principal
│       ├── variables.tf        # Variables del entorno
│       ├── terraform.tfvars    # Valores concretos
│       ├── terraform.tfvars.example # Ejemplo de configuración
│       ├── terraform.tfstate   # Estado de Terraform
│       └── terraform.tfstate.backup
└── WRAPPERS/                   # Wrappers adicionales
```

## 🔧 Requisitos Previos

- **Terraform**: v1.x o superior
- **AWS CLI**: Configurado con `aws configure`
- **Credenciales AWS**: Con permisos para:
  - VPC, Subnets, Internet Gateway, NAT Gateway
  - Security Groups, ALB, Auto Scaling Groups, Launch Templates
- **Región AWS**: `us-east-1` (configurable en `provider.tf`)
- **Acceso a consola AWS**: Para verificar recursos creados

## 🚀 Instalación y Configuración

1. **Clona o descarga el proyecto**:
   ```bash
   cd c:/Users/Eduarw/Downloads/PROYECTO2-TERRAFORM
   ```

2. **Configura las variables** (no subir `terraform.tfvars` al repositorio):
   ```bash
   cp ENVIROMENT/DEV/terraform.tfvars.example ENVIROMENT/DEV/terraform.tfvars
   # Edita ENVIROMENT/DEV/terraform.tfvars con tus valores específicos
   ```

3. **Inicializa Terraform**:
   ```bash
   cd ENVIROMENT/DEV
   terraform init
   ```

## 📋 Uso

### Planificar cambios
```bash
terraform plan 
```

### Aplicar infraestructura
```bash
terraform apply 
```

### Verificar estado
```bash
terraform show
```

### Destruir recursos
```bash
terraform destroy
```

## ⚙️ Variables

### Variables principales (ENVIROMENT/DEV/terraform.tfvars)

| Variable | Descripción | Tipo | Ejemplo |
|----------|-------------|------|---------|
| `vpc_cidr_block` | CIDR block de la VPC | string | `"10.0.0.0/16"` |
| `enable_dns_hostnames` | Habilitar DNS hostnames | bool | `true` |
| `enable_dns_support` | Habilitar soporte DNS | bool | `true` |
| `subnets` | Mapa de subnets | map | Ver ejemplo abajo |
| `ami_id` | ID de la AMI para EC2 | string | `"ami-xxxxxxxxxxxxxxxxx"` |
| `instance_type` | Tipo de instancia EC2 | string | `"t2.micro"` |
| `key_name` | Nombre del key pair | string | `"dev-key"` |
| `environment` | Nombre del entorno | string | `"dev"` |
| `allowed_ssh_cidr` | CIDR permitido para SSH | string | `"0.0.0.0/0"` |
| `desired_capacity` | Capacidad deseada del ASG | number | `2` |
| `max_size` | Tamaño máximo del ASG | number | `3` |
| `min_size` | Tamaño mínimo del ASG | number | `1` |
| `cpu_target_value` | Valor objetivo de CPU para escalado | number | `50` |

### Ejemplo de configuración de subnets
```hcl
subnets = {
  "public-subnet-1" = {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    public           = true
  }
  "public-subnet-2" = {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    public           = true
  }
  "private-subnet-1" = {
    cidr_block        = "10.0.3.0/24"
    availability_zone = "us-east-1a"
    public           = false
  }
  "private-subnet-2" = {
    cidr_block        = "10.0.4.0/24"
    availability_zone = "us-east-1b"
    public           = false
  }
}
```

## 📤 Outputs

Los módulos exponen las siguientes salidas:

### Módulo VPC
- `vpc_id`: ID de la VPC creada
- `public_subnet_ids`: Lista de IDs de subnets públicas
- `private_subnet_ids`: Lista de IDs de subnets privadas

### Módulo ALB_AUTOSCALING
- `alb_dns_name`: Nombre DNS del ALB
- `alb_arn`: ARN del ALB
- `autoscaling_group_name`: Nombre del Auto Scaling Group

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -am 'Agrega nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 🆘 Solución de Problemas

- **Error de credenciales**: Asegúrate de que AWS CLI esté configurado correctamente con `aws configure`
- **Permisos insuficientes**: Verifica que tu usuario IAM tenga los permisos necesarios
- **Región incorrecta**: Confirma que la región en `provider.tf` sea la correcta
- **Dependencias**: Ejecuta `terraform init` después de cualquier cambio en módulos

---

Para más información sobre Terraform, visita [terraform.io](https://www.terraform.io/).
   - `public_subnet = module.vpc.public_subnet_ids`
   - `private_subnet = module.vpc.private_subnet_ids`
4. `MODULES/ALB_AUTOSCALING` usa esto en ALB y ASG.

## 📦 Buenas prácticas

- Usar `terraform fmt -recursive` para formato uniforme.
- Usar `terraform validate` después de editar variables.
- Mantener `terraform.tfvars` fuera del control de versiones (sensible a credenciales/IDs).
- En el futuro, agregar un `backend` remoto al `ENVIROMENT/DEV` (S3+DynamoDB) para compartir estado.

---

### Contacto
- Si quieres, dame info concreta de tu cuenta y región, te preparo `Makefile` y `scripts` para deploy/destruir con un solo comando.

