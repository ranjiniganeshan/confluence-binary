# Input variable definitions

variable "instance_type" {
  description = "Name of the s3 bucket. Must be unique."
  type        = string
}

variable "ami_id" {
  description = "Name of the s3 bucket. Must be unique."
  type        = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "VPC id for web server EC2 instance"
  type        = string
}

variable "private_subnet" {
  description = "Subnet id for web server EC2 instance"
  type        = string
}

variable "public_subnet" {
  description = "Subnet id for web server EC2 instance"
  type        = string
}

variable "ec2_security_group_name" {
  description = "Security group name for web server EC2 instance"
  type        = string
  default     = "main"

}

variable "ec2_security_group_description" {
  description = "Security group description for web server EC2 instance"
  type        = string
  default     = "Allow traffic for webserver"
}