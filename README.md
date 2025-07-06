# Terraform AWS VPC with EC2 Deployment

## 📌 Overview

This project provisions a complete networking setup on AWS using Terraform. It includes:
- A custom Virtual Private Cloud (VPC)
- A public subnet
- An Internet Gateway (IGW)
- A Route Table
- A Security Group to allow SSH access
- An EC2 instance deployed inside the public subnet with SSH key pair access

---

## 🛠️ Technologies Used

- Terraform
- AWS CLI
- AWS VPC, EC2, Subnets, Route Tables, Internet Gateway
- SSH + Key Pairs + Security Groups

---

## 🧱 Infrastructure Architecture

- **VPC**: 10.0.0.0/16
- **Subnet**: 10.0.1.0/24 (Public)
- **IGW**: Enables internet access
- **Route Table**: Directs traffic to the IGW
- **EC2 Instance**: Amazon Linux 2 (AMI ID: `ami-05ffe3c48a9991133`)
- **Security Group**: Allows inbound SSH (port 22)
- **Key Pair**: `terraform-key.pem` (created manually in AWS)

---

## 🚀 How to Use

### 1. Prerequisites
- Terraform installed
- AWS CLI configured
- Valid AWS key pair created and downloaded

### 2. Clone the Repository

```bash
git clone https://github.com/AnnuRLohan/terraform-aws-vpc-ec2.git
cd terraform-aws-vpc-ec2
