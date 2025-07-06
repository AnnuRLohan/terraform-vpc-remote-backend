output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "ec2_instance_public_ip" {
  value = aws_instance.web.public_ip
}