output "vpc_id-uswest2"{
value=aws_vpc.uswest2-vpc-1
}


output "route_table_private_ID_uswest2" {
    value = aws_route_table.rt-private-uswest2.id  
}
# output "subnet_ids-public"{
# value=[aws_subnet.my-subnet-public-useast1.*.id]
# }

# output "subnet_ids-private"{
# value=[aws_subnet.my-subnet-private-useast1.*.id]
# }