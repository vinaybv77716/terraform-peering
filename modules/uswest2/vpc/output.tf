output "vpc_id-uswest2"{
value=aws_vpc.uswest2-vpc-1.id
}
output "subnet_ids-public-uswest2"{
value=[aws_subnet.my-subnet-public-uswest2.*.id]
}

output "subnet_ids-private-uswest2"{
value=[aws_subnet.my-subnet-private-uswest2.*.id]
}

output "rt-public-uswest2" {
  value = aws_route_table.rt-public-uswest2.id
}
output "route_table_private_ID_uswest2" {
    value = aws_route_table.rt-private-uswest2.id  
}