[Associate access policies with access entries](https://docs.aws.amazon.com/eks/latest/userguide/access-policies.html)

[terraform-aws-eks-pod-identity](https://github.com/terraform-aws-modules/terraform-aws-eks-pod-identity)

[How to Create IAM Roles for EKS Service Accounts in Terraform](https://oneuptime.com/blog/post/2026-02-23-how-to-create-iam-roles-for-eks-service-accounts-in-terraform/view)

[Submodule: iam-role-for-service-accounts](https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/latest/submodules/iam-role-for-service-accounts)

To find the policy_arn and role names for your AWS EKS Terraform code, you can reference them either directly as static strings for managed AWS policies or dynamically by interpolating existing Terraform resources.
## 1. Static Managed Policy ARNs (Standard EKS Permissions)
If you are attaching default AWS-managed policies to your cluster role or worker node role via the aws_iam_role_policy_attachment resource, you can pass the strings directly into your code: [1] 

* For the EKS Cluster Role: ```arn:aws:iam::aws:policy/AmazonEKSClusterPolicy```
* For the Worker Node Group Role: ```arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy```, ```arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy```, and ```arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly``` [1] 

```
resource "aws_iam_role_policy_attachment" "cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name # References the role name attribute
}
```

------------------------------
## 2. Dynamically Referencing Resources (Best Practice)
If you are creating custom IAM policies or IAM roles inside your Terraform setup, you should never hardcode the values. Instead, use Terraform's resource attributes to reference them dynamically. [2] 

* For role: Use .name to satisfy arguments that ask for a role name.
* For policy_arn: Use .arn to pass the Amazon Resource Name. [1, 2] 

# 1. Define the IAM Role
```
resource "aws_iam_role" "my_eks_role" {
  name               = "my-eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
```

# 2. Define a Custom IAM Policy
```
resource "aws_iam_policy" "my_custom_policy" {
  name        = "my-custom-eks-policy"
  description = "My custom policy for EKS"
  policy      = jsonencode({ /* actions and resources */ })
}
```

# 3. Attach them together using .name and .arn
```
resource "aws_iam_role_policy_attachment" "attachment" {
  role       = aws_iam_role.my_eks_role.name      # Extracts the role name
  policy_arn = aws_iam_policy.my_custom_policy.arn # Extracts the policy ARN
}
```

------------------------------
## 3. Fetching Pre-existing AWS Policies via Data Sources
If the policy or role already exists in your AWS account and wasn't created by your current Terraform code, use a Data Source block to search for and retrieve it:

# Fetch an existing policy by its name
```
data "aws_iam_policy" "existing_policy" {
  name = "AmazonEKSClusterPolicy" 
}
```

# Fetch an existing role by its name
```
data "aws_iam_role" "existing_role" {
  name = "my-pre-existing-role"
}
```

# Reference their attributes in your infrastructure
```
resource "aws_eks_cluster" "example" {
  name     = "example-cluster"
  role_arn = data.aws_iam_role.existing_role.arn # Returns the ARN needed for EKS
  # ...
}
```


If you are trying to implement IAM Roles for Service Accounts (IRSA) or EKS Pod Identities, let me know! I can provide the exact code block for those setups. [3] 

[1] [https://registry.terraform.io](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)
[2] [https://developer.hashicorp.com](https://developer.hashicorp.com/terraform/tutorials/aws/aws-iam-policy)
[3] [https://registry.terraform.io](https://registry.terraform.io/providers/-/aws/latest/docs/resources/eks_pod_identity_association)
