#vpc
resource "aws_vpc" "uswest2-vpc-1"{
    cidr_block=var.uswest2-vpc-cidr
    provider = aws.uswest2
    tags={
        "Name"="uswest2-vpc-1"
    }
}
##############################################

#PublicSubnet
resource "aws_subnet" "my-subnet-public-uswest2"{
    vpc_id=aws_vpc.uswest2-vpc-1.id
    provider = aws.uswest2
    map_public_ip_on_launch=true
    cidr_block=var.uswest2-PublicSubnet-cidr[count.index]
    count=length(var.uswest2-PublicSubnet-cidr)
      availability_zone = var.availability_zone-subnets
}
###############################################

#PrivateSubnet
resource "aws_subnet" "my-subnet-private-uswest2"{
    vpc_id=aws_vpc.uswest2-vpc-1.id
    provider = aws.uswest2
    cidr_block=var.uswest2-PrivateSubnet-cidr[count.index]
    count=length(var.uswest2-PrivateSubnet-cidr)
      availability_zone = var.availability_zone-subnets
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
  count = length(var.uswest2-PublicSubnet-cidr)
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
  count = length(var.uswest2-PrivateSubnet-cidr)
  provider = aws.uswest2
subnet_id=aws_subnet.my-subnet-private-uswest2.id
route_table_id=aws_route_table.rt-private-uswest2.id
}