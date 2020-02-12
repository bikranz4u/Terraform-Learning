# VPC Networking Settings
#################################CREATE VPC######################################
resource "aws_vpc" "main" {
  # Name                             = var.vpc_name
  cidr_block                       = var.vpc_cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  tags = {
    Name = "custom-vpc"
  }
}

################################# CREATING INTERNET GATEWAY ########################

resource "aws_internet_gateway" "internet_gateway-rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "custom-igw"
  }
}

################################# CREATING A PUBLIC ROUTE TABLE ###################
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway-rt.id
  }

  tags = {
    Name = "public-RT"
  }
}

################################# CREATING A PRIVATE ROUTE TABLE ###################
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-RT"
  }
}

################################## DETAILS FOR AVAILABLITY ZONES PRESENT ##########
data "aws_availability_zones" "available" {}

#################################CREATING A PUBLIC SUBNET #########################
resource "aws_subnet" "public-sn" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr #<- Update this value in vars.tf ,as per requirement
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "public-subnet"
  }
}

#################################CREATING A PRIVATE SUBNET #########################
resource "aws_subnet" "private-sn" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidr #<- Update this value in vars.tf, as per requirement
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "private-subnet"
  }
}

#############################SUBNET ASSOCIATION TO ROUTE TABLE######################
resource "aws_route_table_association" "public-assoc" {
  subnet_id      = aws_subnet.public-sn.id
  route_table_id = aws_route_table.public-rt.id
  # tags = {
  #   name = "public-sn-assoc"
  # }
}

resource "aws_route_table_association" "private-assoc" {
  subnet_id      = aws_subnet.private-sn.id
  route_table_id = aws_route_table.private-rt.id

  # tags = {
  #   name = "private-sn-assoc"
  # }
}
