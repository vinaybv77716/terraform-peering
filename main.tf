###########  vpc  ##########
module "vpc-useast1"{
    source="./modules/useast1/vpc"
     vpc-cidr-useast1=var.vpc-cidr-useast1
     subnet-cidr-useast1=var.subnet-cidr-useast1
     subnet-cidr-private-useast1=var.subnet-cidr-private-useast1
}
module "vpc-uswest2"{
    source="./modules/uswest2/vpc"
    uswest2-vpc-cidr=var.uswest2-vpc-cidr
    uswest2-PublicSubnet-cidr=var.uswest2-PublicSubnet-cidr
    uswest2-PrivateSubnet-cidr=var.uswest2-PrivateSubnet-cidr
    availability_zone-subnets=var.availability_zone-subnets
}


###########  SG  ##########
module "mysg-useast1"{
    source="./modules/useast1/sg"
   vpc_id=module.vpc-useast1.vpc_id
}
module "mysg-uswest2"{
    source="./modules/uswest2/sg"
    vpc_id=module.vpc-uswest2.vpc_id-uswest2
}


###########  instance  ##########
module "ec2-useast1" {
  source = "./modules/useast1/instance"
  pub-useast1-ami =var.pub-useast1-ami
  all-instance-type=var.all-instance-type
  sg_id = module.mysg-useast1.sg_id
  key_name-useast1 = var.key_name-useast1
   #public-subnetsID-useast1 = module.vpc-useast1.subnet_ids-public
   public-subnetsID-useast1 = element(module.vpc-useast1.subnet_ids-public, 0)
    #private-subnetsID-useast1 = module.vpc-useast1.subnet_ids-private
    private-subnetsID-useast1 = element(module.vpc-useast1.subnet_ids-private, 0)
}
module "ec2-uswest2" {
  source = "./modules/uswest2/instance"
  uswest2-ami = var.uswest2-ami
  all-instance_type=var.all-instance_type
  uswest2-sg = module.mysg-uswest2.uswest2-sg-ID
  uswest2-key_name=var.uswest2-key_name
  uswest2-PublicSubnet-ID=element(module.vpc-uswest2.subnet_ids-public-uswest2, 0)
  uswest2-PrivateSubnet-ID=element(module.vpc-uswest2.subnet_ids-private-uswest2, 0)
}


###########  peering  ##########
module "peering-conection" {
  source = "./modules/peering"
  vpc_id-useast1=module.vpc-useast1.vpc_id
  vpc_id-uswest2 = module.vpc-uswest2.vpc_id-uswest2
  peer_region = var.peer_region
  auto_accept = var.auto_accept
  peer_accept = var.peer_accept
  route_table_id-public = module.vpc-useast1.rt-public-useast1
  route_table_id-private=module.vpc-uswest2.route_table_private_ID_uswest2
}
