# Terraform AWS VPC with Remote Backend (S3 + DynamoDB)

## 🧾 Overview

This project provisions a custom AWS VPC with a public subnet and an EC2 instance using Terraform.  
It also uses a **remote backend** (S3) and **state locking** (DynamoDB) to manage the Terraform state securely and support team workflows.

---

## 🛠️ Tools & Services Used

- Terraform
- AWS S3 (remote state backend)
- AWS DynamoDB (state locking)
- AWS EC2, VPC, Subnet, Internet Gateway, Route Table
- SSH Key Pair

---

## 🧱 Architecture

- **VPC**: 10.0.0.0/16
- **Public Subnet**: 10.0.1.0/24
- **Internet Gateway + Route Table**: Enables internet access
- **Security Group**: Allows SSH access (port 22)
- **EC2 Instance**: Amazon Linux 2
- **Remote Backend**:
  - `terraform-state-annu` (S3 bucket)
  - `terraform-locks` (DynamoDB table)

---

## 🔐 Terraform Backend Configuration

```hcl
terraform {
  backend "s3" {
    bucket         = "terraform-state-annu"
    key            = "vpc-ec2/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
