# Input variable definitions

variable "cidr_block" {
  description = "cidr_block."
  type        = string
}


variable "subnet1_cidr" {
  description = "subnet_cidr."
  type        = string
}

variable "subnet2_cidr" {
  description = "subnet_cidr."
  type        = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}
