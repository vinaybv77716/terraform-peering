output "vpc_id"{
value=aws_vpc.useast1-vpc-1.id
}

output "subnet_ids-public"{
value=[aws_subnet.my-subnet-public-useast1.*.id]
}

output "subnet_ids-private"{
value=[aws_subnet.my-subnet-private-useast1.*.id]
}

output "rt-public-useast1" {
  value = aws_route_table.rt-public-useast1.id
}