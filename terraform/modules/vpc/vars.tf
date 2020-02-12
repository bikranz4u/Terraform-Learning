variable "vpc_cidr_block" {
  default     = "192.168.0.0/20" #<- Change as per requirement
  description = "CIDR range for the VPC"
}

variable "public_subnet_cidr" {
  description = "This is the cidr range for public subnet on VPC"
  default     = "192.168.0.0/23" #Range 128 IPs #<- Change as per requirement
}

variable "private_subnet_cidr" {
  description = "This is the cidr range for private subnet on VPC"
  default     = "192.168.2.0/23" #Range 128 IPs   #<-Change as per requirement
}


variable "instance_tenancy" {
  default = "default"
}

variable "vpc_name" {
  default     = "main"
  description = "Name of the vpc"
}

variable "enable_dns_support" {
  default = true
}

variable "enable_dns_hostnames" {
  default = true

}

variable "assign_generated_ipv6_cidr_block" {
  default = false
}
