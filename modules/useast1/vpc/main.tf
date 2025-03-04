#vpc
resource "aws_vpc" "useast1-vpc-1"{
    cidr_block=var.vpc-cidr-useast1
    provider = aws.useast1
    tags={
        "Name"="useast1-vpc-1"
    }
}

#Subnet
resource "aws_subnet" "my-subnet-public-useast1"{
    vpc_id=aws_vpc.useast1-vpc-1.id
    map_public_ip_on_launch=true
    provider = aws.useast1
    cidr_block=var.subnet-cidr-useast1[count.index]
    count=length(var.subnet-cidr-useast1)
      availability_zone = "us-east-1a"
}

#Subnet
resource "aws_subnet" "my-subnet-private-useast1"{
    vpc_id=aws_vpc.useast1-vpc-1.id
    provider = aws.useast1
    cidr_block=var.subnet-cidr-private-useast1[count.index]
    count=length(var.subnet-cidr-private-useast1)
      availability_zone = "us-east-1a"
}

#Internet-Gateway
resource "aws_internet_gateway" "igw-useast1"{
  provider = aws.useast1
    vpc_id=aws_vpc.useast1-vpc-1.id
}

#Rout-Tabel-public
resource "aws_route_table" "rt-public-useast1" {
  provider = aws.useast1
    vpc_id=aws_vpc.useast1-vpc-1.id
    route{
        cidr_block="0.0.0.0/0"
        gateway_id=aws_internet_gateway.igw-useast1.id
    }
}

#Subnet-assocation-public
resource "aws_route_table_association" "rtas-public-useast1" {
  count = length(var.subnet-cidr-useast1)
  provider = aws.useast1
subnet_id=aws_subnet.my-subnet-public-useast1.id[count.index]
route_table_id=aws_route_table.rt-public-useast1.id 
}

# Create a NAT gateway with an Elastic IP for each private subnet to get internet connectivity
resource "aws_eip" "gw-useast1" {
  provider = aws.useast1
  #count      = var.az_count #2
  vpc        = true
  depends_on = [aws_internet_gateway.igw-useast1]
}
resource "aws_nat_gateway" "gw-east" {
  #count         = var.az_count
  provider = aws.useast1
  subnet_id=aws_subnet.my-subnet-public-useast1.id[count.index]
  allocation_id = aws_eip.gw-useast1.id 
  depends_on = [aws_internet_gateway.igw-useast1]
}

#Rout-Tabel-private
resource "aws_route_table" "rt-private-useast1" {
    vpc_id=aws_vpc.useast1-vpc-1.id
    provider = aws.useast1
    route{
        cidr_block="0.0.0.0/0"
        gateway_id=aws_nat_gateway.gw-east.id
    }
}

#Subnet-assocation-private
resource "aws_route_table_association" "rtas-private-useast1" {
  count = length(var.subnet-cidr-private-useast1)
  provider = aws.useast1
subnet_id=aws_subnet.my-subnet-private-useast1.id[count.index]
route_table_id=aws_route_table.rt-private-useast1.id
}