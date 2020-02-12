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

variable "instance_tenancy" {
  default = "default"
}
# variable "vpc_cidr_block" {}


#  USER PROFILE
variable "aws_credentials_file_path" {
  type    = string
  default = "/Users/bikrdas/.aws/credential"
}

variable "aws_profile_name" {
  type    = string
  default = "bharath"
}
