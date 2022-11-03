output "vpc_id" {
  description = "ID of the vpc"
  value       = module.vpc.vpc_id
}

output "instance_id" {
  description = "ID of EC2 instance"
  value       = module.ec2.instance_id
}
