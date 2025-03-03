#vpc
resource "aws_vpc" "uswest2-vpc-1"{
    cidr_block="20.0.0.0/16"
    provider = aws.uswest2
    tags={
        "Name"="uswest2-vpc-1"
    }
}
##############################################

#Subnet
resource "aws_subnet" "my-subnet-public-uswest2"{
    vpc_id=aws_vpc.uswest2-vpc-1.id
    provider = aws.uswest2
    map_public_ip_on_launch=true
    cidr_block="20.0.1.0/24"
    #count=length(var.subnet-cidr)
      availability_zone = "us-west-2a"
}
###############################################

#Subnet
resource "aws_subnet" "my-subnet-private-uswest2"{
    vpc_id=aws_vpc.uswest2-vpc-1.id
    provider = aws.uswest2
    cidr_block="20.0.2.0/24"
    #count=length(var.subnet-cidr)
      availability_zone = "us-west-2a"
}
##############################################

#Internet-Gateway
resource "aws_internet_gateway" "igw-uswest2"{
  provider = aws.uswest2
    vpc_id=aws_vpc.uswest2-vpc-1.id
}
################################################

#Rout-Tabel-public
resource "aws_route_table" "rt-public-uswest2" {
    vpc_id=aws_vpc.uswest2-vpc-1.id
    provider = aws.uswest2
    route{
        cidr_block="0.0.0.0/0"
        gateway_id=aws_internet_gateway.igw-uswest2.id
    }
}
#################################################

#Subnet-assocation-public
resource "aws_route_table_association" "rtas-public-uswest2" {
  #count = length(var.subnet-cidr)
  provider = aws.uswest2
subnet_id=aws_subnet.my-subnet-public-uswest2.id
route_table_id=aws_route_table.rt-public-uswest2.id 
}
#################################################



resource "aws_eip" "gw-uswest2" {
  provider = aws.uswest2
  #count      = var.az_count #2
  vpc        = true
  depends_on = [aws_internet_gateway.igw-uswest2]
}
resource "aws_nat_gateway" "gw-west" {
  provider = aws.uswest2
  #count         = var.az_count
  subnet_id=aws_subnet.my-subnet-public-uswest2.id
  allocation_id = aws_eip.gw-uswest2.id 
}
#####################################################

#Rout-Tabel-private
resource "aws_route_table" "rt-private-uswest2" {
    vpc_id=aws_vpc.uswest2-vpc-1.id
    provider = aws.uswest2
    route{
        cidr_block="0.0.0.0/0"
        gateway_id=aws_nat_gateway.gw-west.id
    }
}
###################################################

#Subnet-assocation-private
resource "aws_route_table_association" "rtas-private-uswest2" {
  #count = length(var.subnet-cidr)
  provider = aws.uswest2
subnet_id=aws_subnet.my-subnet-private-uswest2.id
route_table_id=aws_route_table.rt-private-uswest2.id
}