# DEFAULT REGION US_EAST AMERICAS
variable "region" {
default = "us-east-2"
}
#CIDR for public vpc for Angad test1234

variable "cidr_vpc" {
default = "9.0.0.0/16"
}

# ADD PROVIDER
variable "provider_name" {
default = "aws-t-vpc-0001"
}

variable "igw_name" {
default = "aws-t-igw-0001"
}

variable "cidr_rt" {
default = "0.0.0.0/0"
}

variable "ipv6_cidr_rt" {
default = "::/0"
}

variable "rt_name" {
default = "aws-t-rt-0001"
}

variable "cidr_subnet" {
default = "9.0.1.0/24"
}

variable "subnet_az" {
default = "us-east-2a"
}

variable "subnet_name" {
default = "aws-t-subnet-0001"
}

variable "sg_name" {
default = "aws-t-sg-0001"
}

variable "ni_name" {
default = "aws-t-ni-0001"
}

variable "eip_name" {
default = "aws-t-eip-0001"
}
