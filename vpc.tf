# create vpc 

resource "aws_vpc" "VPC_s3" {
  cidr_block           = "20.10.0.0/16"
  enable_dns_hostnames = true

  tags = local.tags
}

# create the igw for vpc

resource "aws_internet_gateway" "VPC_s3-igw" {
  vpc_id = aws_vpc.VPC_s3.id

  tags = local.tags
}

# create the public subnet

resource "aws_subnet" "pub-subnetVPC-s3" {
  vpc_id                  = aws_vpc.VPC_s3.id
  cidr_block              = element(var.pub-subnet-cidr, 0)
  availability_zone       = "${local.region}a"
  map_public_ip_on_launch = true

  tags = local.tags
}

# create the public route table

resource "aws_route_table" "pub-rtb" {
  vpc_id = aws_vpc.VPC_s3.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.VPC_s3-igw.id
  }
}

# create pub route table association

resource "aws_route_table_association" "pub-rtb-assoc" {
  subnet_id      = aws_subnet.pub-subnetVPC-s3.id
  route_table_id = aws_route_table.pub-rtb.id
}

# create the private subnet

resource "aws_subnet" "priv-subnetVPC-s3" {
  vpc_id                  = aws_vpc.VPC_s3.id
  cidr_block              = element(var.priv-subnet-cidr, 0)
  availability_zone       = "${local.region}b"
  map_public_ip_on_launch = false

  tags = local.tags
}

# create the private route table

resource "aws_route_table" "priv-rtb" {
  vpc_id = aws_vpc.VPC_s3.id
}


# create priv route table association

resource "aws_route_table_association" "priv-rtb-assoc" {
  subnet_id      = aws_subnet.priv-subnetVPC-s3.id
  route_table_id = aws_route_table.priv-rtb.id
}

#### to connect with the amazon s3 bucket from the with the aws network
#### through the vpc gateway endpoint with internet, the vpc endpoint is created
#### and the private subnet route table is modified

resource "aws_vpc_endpoint" "s3connection" {
  vpc_id       = aws_vpc.VPC_s3.id
  service_name = "com.amazonaws.us-east-1.s3"
  auto_accept  = true
}

resource "aws_vpc_endpoint_route_table_association" "rtb-association" {
  route_table_id  = aws_route_table.priv-rtb.id
  vpc_endpoint_id = aws_vpc_endpoint.s3connection.id
}