###########  peering  ############

resource "aws_vpc_peering_connection" "peer" {
  provider   = aws.useast1
  vpc_id     = var.vpc_id-useast1
  peer_vpc_id = var.vpc_id-uswest2
  peer_region = var.peer_region
  auto_accept = var.auto_accept

  tags = {
    Name = "cross-region-vpc-peering"
  }
}

resource "aws_vpc_peering_connection_accepter" "peer_accept" {
  provider                  = aws.uswest2
  vpc_peering_connection_id = aws_vpc_peering_consnection.peer.id  ########  dought  #######
  auto_accept               = var.peer_accept

  tags = {
    Name = "peer-accept"
  }
}

#update rout tabel
resource "aws_route" "route_vpc1_to_vpc2" {
  provider            = aws.useast1
  route_table_id      = var.route_table_id-private
  destination_cidr_block = "20.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}


#update rout tabel
resource "aws_route" "route_vpc2_to_vpc1" {
  provider            = aws.uswest2
  route_table_id      = var.route_table_id-public  
  destination_cidr_block = "10.0.0.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}