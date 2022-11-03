output "vpc_id" {
  description = "ARN of the bucket"
  value       = aws_vpc.confluence.id
}

output "private_subnet_id" {
  description = "ARN of the bucket"
  value       = aws_subnet.private_subnet.id
}

output "public_subnet_id" {
  description = "ARN of the bucket"
  value       = aws_subnet.public_subnet.id
}

output "igw_id" {
  description = "ARN of the bucket"
  value       = aws_internet_gateway.confluenceigw.id
}

