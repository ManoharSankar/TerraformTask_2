# AWS region variables
variable "region_1" {
  description = "First AWS region"
  default     = "ap-south-1"
}

variable "region_2" {
  description = "Second AWS region"
  default     = "ap-southeast-1"
}

# Instance type variable
variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

# AMI for Ubuntu in both regions
variable "ami_south" {
  description = "AMI ID for Ubuntu in ap-south-1"
  default     = "ami-0522ab6e1ddcc7055"  
}

variable "ami_southeast" {
  description = "AMI ID for Ubuntu in ap-southeast-1"
  default     = "ami-01811d4912b4ccb26"
}

# Security group names for both regions
variable "security_group_name_1" {
  description = "Name of the security group in the first region"
  default     = "nginx_sg_mumbai"
}

variable "security_group_name_2" {
  description = "Name of the security group in the second region"
  default     = "nginx_sg_singapore"
}

