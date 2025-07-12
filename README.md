
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
  - S3 Bucket: `terraform-state-annu`
  - DynamoDB Table: `terraform-locks`

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
```

---

## 🚀 How to Use

### 1. Prerequisites

- AWS CLI configured (`aws configure`)
- Terraform installed (`terraform -version`)
- A key pair created in AWS (e.g., `terraform-key.pem`)

### 2. Clone the Repository

```bash
git clone https://github.com/AnnuRLohan/terraform-vpc-remote-backend.git
cd terraform-vpc-remote-backend
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review the Execution Plan

```bash
terraform plan
```

### 5. Apply the Configuration

```bash
terraform apply
```

### 6. SSH into the EC2 Instance

```bash
ssh -i terraform-key.pem ec2-user@<EC2_PUBLIC_IP>
```

> Replace `<EC2_PUBLIC_IP>` with the actual public IP from the Terraform output.

---

## 🧹 Cleanup Resources

To destroy the created infrastructure:

```bash
terraform destroy
```

---

## 📁 Project Structure

```
terraform-vpc-remote-backend/
├── main.tf
├── variables.tf
├── outputs.tf
├── backend.tf
└── README.md
```

---

## 📌 Notes

- Make sure the S3 bucket and DynamoDB table exist **before** running `terraform init`.
- Remote backend helps in team collaboration and prevents state file corruption with state locking.
- Always keep your private key (`terraform-key.pem`) secure and never commit it to version control.

---

## 👨‍💻 Author

**Annu Lohan**  
DevOps Enthusiast | Practical Learner | Automation Lover  
🔗 [LinkedIn](https://www.linkedin.com/in/annulohan) | 🛠️ [More Projects](https://github.com/AnnuRLohan)
