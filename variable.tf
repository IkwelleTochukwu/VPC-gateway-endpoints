variable "module_name" {
  description = "name to be assigned to all the resources created in this config."
  type        = string
  default     = "s3_resource-project"
}

variable "aws_region" {
  description = "region of deployment"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "tag name for the resources"
  type        = map(string)
  default = {
    "env"     = "apps"
    "project" = "demo"
  }
}

variable "ami" {
  description = "the ami for the instance"
  type        = string
  default     = "ami-052efd3df9dad4825" #####Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2022-06-09### for us-east-1 region

}

variable "instance_type" {
  description = "the instance type"
  type        = string
  default     = "t2.micro"
}

variable "aws_s3_bucket" {
  description = "the name of the bucket"
  type        = string
  default     = "www.s3bucketdemomodule.tk"
}

variable "pub-subnet-cidr" {
  description = "the cidr block for the public subnet"
  type        = list(string)
  default = [
    "20.10.10.0/24",
    "20.10.20.0/24",
    "20.10.30.0/24",
    "20.10.40.0/24",
    "20.10.50.0/24",
  ]
}

variable "priv-subnet-cidr" {
  description = "the cidr block for the private subnet"
  type        = list(string)
  default = [
    "20.10.1.0/24",
    "20.10.2.0/24",
    "20.10.3.0/24",
    "20.10.4.0/24",
    "20.10.5.0/24",
  ]
}