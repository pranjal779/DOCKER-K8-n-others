[<img width="872" height="155" alt="image" src="https://github.com/user-attachments/assets/ffec4dbb-f161-4ffb-be8c-d0d8e06436d4" />](https://youtu.be/a_j6Gq-KtxE?si=mRiGoXgOpL7IzTzA)


[20/30 - Terraform Custom Modules for EKS - From Zero to Production](https://youtu.be/a_j6Gq-KtxE?si=Hu5nO56dyOsbiXre)

https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest

When creating custom modules for Amazon EKS in Terraform, the primary goal is to abstract the complex, underlying boilerplate resources (VPC, IAM, Node Groups, Add-ons) into a clean, repeatable interface for your organization. [1, 2] 
Instead of treating the Official terraform-aws-modules/eks as an all-or-nothing tool, you can build a custom "wrapper" module around it or wrap the raw aws_eks_cluster resources directly to enforce your company’s compliance and architecture policies. [1, 3, 4] 
## 📂 Recommended Folder Structure
A production-grade custom module isolates the network, control plane, and core extensions into sub-modules: [2, 5] 

```txt
my-eks-infrastructure/
├── main.tf                 # Root module: orchestrates variables into child modules
├── variables.tf            # Root variables
├── outputs.tf              # Root outputs exposed to the environment
└── modules/
    ├── vpc/                # Custom VPC sub-module (Subnets, NAT, IGW)
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── eks/                # Custom EKS control plane & data plane sub-module
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

------------------------------
## 💻 Code Blueprint for a Custom EKS Module
Below is a blueprint showing how to wrap the official AWS EKS module inside your own custom infrastructure block to deploy an EKS Auto Mode configuration or a managed Node Group cleanly. [4, 6] 

```tf
## 1. Inside modules/eks/main.tf (The Custom Module)

# modules/eks/main.tf

# Define the underlying EKS Cluster using official primitives or specific overrides
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0" # Keeps up with modern features like EKS Auto Mode

  cluster_name    = var.custom_cluster_name
  cluster_version = var.kubernetes_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  # Enable modern cluster creator admin permissions by default for safety
  enable_cluster_creator_admin_permissions = true

  # Toggle between EKS Auto Mode or Custom Managed Node Groups
  compute_config = {
    enabled    = var.enable_auto_mode
    node_pools = ["general-purpose"]
  }

  tags = merge(
    {
      Environment = var.environment
      ManagedBy   = "Terraform-Custom-Module"
    },
    var.additional_tags
  )
}

## 2. Inside modules/eks/variables.tf (Module Inputs)

variable "custom_cluster_name" {
  type        = string
  description = "The name of the EKS cluster."
}

variable "kubernetes_version" {
  type        = string
  default     = "1.33"
}

variable "vpc_id" {
  type        = string
}

variable "private_subnet_ids" {
  type        = list(string)
}

variable "enable_auto_mode" {
  type        = bool
  default     = true
}

variable "environment" {
  type        = string
}

variable "additional_tags" {
  type        = map(string)
  default     = {}
}

## 3. Inside the Root main.tf (Calling your Custom Module)

# main.tf (Root Directory)

# 1. Instantiate Network from your custom VPC module
module "network" {
  source = "./modules/vpc"
  
  cidr_block = "10.0.0.0/16"
  env        = "production"
}

# 2. Instantiate EKS passing attributes outputted by the VPC module
module "production_eks" {
  source = "./modules/eks"

  custom_cluster_name = "corp-prod-mesh"
  kubernetes_version  = "1.33"
  vpc_id              = module.network.vpc_id
  private_subnet_ids  = module.network.private_subnets
  enable_auto_mode    = true
  environment         = "production"
}
```
------------------------------
## 🛡️ Production Best Practices for Custom Modules

   1. Decouple Cluster Configuration from Infrastructure: Keep add-ons (like Helm charts, ArgoCD, or internal tools) separate from core compute. Utilize specialized downstream tools like [EKS Blueprints Addons](https://github.com/aws-ia/terraform-aws-eks-blueprints) rather than bloating your custom base module. [7, 8] 
   2. Isolate State Changes: Ensure your custom network sub-module does not share a tight execution boundary with your nodes. If a node configuration breaks during a run, you don't want it locking or altering your critical VPC architecture. [2, 5] 
   3. Enforce Version Pins: Pin both the child module source provider versions and the explicit kubernetes_version inside your defaults to avoid unexpected cluster upgrades when someone runs an environment-wide terraform apply. [4] 

Would you like to build this module around EKS Managed Node Groups with spot instances instead of EKS Auto Mode? Let me know, and I can modify the configuration block or guide you on setting up the custom VPC sub-module structure. [2, 6, 9] 

[1] [https://www.youtube.com](https://www.youtube.com/watch?v=a_j6Gq-KtxE&t=116)
[2] [https://www.youtube.com](https://www.youtube.com/watch?v=j0lEXMyWQnE)
[3] [https://www.youtube.com](https://www.youtube.com/watch?v=385byZe8fM8)
[4] [https://registry.terraform.io](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/21.2.0)
[5] [https://dev.to](https://dev.to/amit_kumar_7db8e36a64dd45/-day-20-terraform-custom-modules-for-eks-from-zero-to-production-4j92)
[6] [https://registry.terraform.io](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest)
[7] [https://registry.terraform.io](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/18.16.0)
[8] [https://github.com](https://github.com/aws-ia/terraform-aws-eks-blueprints)
[9] [https://dev.to](https://dev.to/anil_kumar_noolu/day-20-terraform-custom-modules-for-eks-31lh)
