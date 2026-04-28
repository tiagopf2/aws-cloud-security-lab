# Terraform — Infrastructure as Code

This directory contains the Terraform configuration that describes the entire AWS environment built in this project. These files are provided for **documentation and reproducibility purposes**.

---

## File Structure

| File | Purpose |
|---|---|
| `main.tf` | Provider configuration |
| `variables.tf` | Input variables (region, key pair, admin IP, bucket name) |
| `vpc.tf` | Primary VPC, Secondary VPC, Subnets, Route Tables, VPC Peering |
| `ec2.tf` | EC2 Instances (Linux, Windows, Linux2) + Security Groups |
| `iam.tf` | IAM Users, Groups, Memberships, Deny Policies |
| `s3.tf` | S3 Bucket, Block Public Access, Encryption, Bucket Policy |
| `cloudwatch.tf` | Billing Alarm, SNS Topic, CloudWatch Dashboard |
| `nacl.tf` | Network ACL rules for the public subnet |
| `outputs.tf` | Output values (Instance IDs, VPC IDs, Bucket Name) |

---

## How to Use

### Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.3.0
- AWS CLI configured with valid credentials (`aws configure`)

### Steps

```bash
# 1. Initialize Terraform
terraform init

# 2. Preview the execution plan
terraform plan -var="admin_ip=YOUR.IP.HERE/32"

# 3. Apply the configuration
terraform apply -var="admin_ip=YOUR.IP.HERE/32"

# 4. Destroy all resources when done (IMPORTANT for cost control)
terraform destroy
```

---

## Security Notes
- **Never hardcode your AWS Account ID or Access Keys** in `.tf` files. Use `data "aws_caller_identity"` to fetch the account ID dynamically (as done in `s3.tf`).
- **`admin_ip` is marked as `sensitive`** in `variables.tf` to prevent it from appearing in logs.
- **Always run `terraform destroy`** after testing to avoid unexpected charges.
- A `.gitignore` should exclude `terraform.tfstate`, `terraform.tfstate.backup`, and `.terraform/` from version control.

---

## .gitignore Recommendation

```
# Terraform
.terraform/
.terraform.lock.hcl
terraform.tfstate
terraform.tfstate.backup
*.tfvars
```
