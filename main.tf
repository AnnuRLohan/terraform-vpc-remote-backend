provider "aws" {
    region = var.aws_region
}

# VPC 
resource "aws_vpc" "main_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "DevOps-VPC"
    }
}

# Subnet (Public)
resource "aws_subnet" "public_subnet" {
    vpc_id             = aws_vpc.main_vpc.id
    cidr_block         = "10.0.1.0/24"
    availability_zone  = var.availability_zone

    tags = {
        Name = "Public-Subnet"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
        Name = "DevOps-IGW"  
    }
}

# Route Table
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "Public-RT"
    }
}

# Route Table Association
resource "aws_route_table_association" "public_rt_assoc" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id 
}

# Sevcurity Group for EC2
resource "aws_security_group" "ec2_sg" {
    name       = "ec2_allow_ssh"
    description = "Allow SSH inbound traffic"
    vpc_id      = aws_vpc.main_vpc.id

    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    =  "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    =  "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "EC2-SG"
    }
}

# EC2 Instance in Public Subnet
resource "aws_instance" "web" {
    ami                         = var.ami_id
    instance_type               = var.instance_type
    subnet_id                   = aws_subnet.public_subnet.id
    associate_public_ip_address = true
    key_name                    = var.key_name
    vpc_security_group_ids      = [aws_security_group.ec2_sg.id]

    tags = {
        Name  = "Web-Instance"
    }
}

