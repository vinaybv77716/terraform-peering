###########  vpc  ##########
module "vpc-useast1"{
    source="./modules/useast1/vpc"
     vpc-cidr-useast1=var.vpc-cidr-useast1
     subnet-cidr-useast1=var.subnet-cidr-useast1
     subnet-cidr-private-useast1=var.subnet-cidr-private-useast1
}
module "vpc-uswest2"{
    source="./modules/uswest2/vpc"
    # vpc-cidr=var.vpc-cidr
    # subnet-cidr=var.subnet-cidr
}


###########  SG  ##########
module "mysg-useast1"{
    source="./modules/useast1/sg"
   vpc_id=module.vpc-useast1.vpc_id
}
module "mysg-uswest2"{
    source="./modules/uswest2/sg"
   # vpc_id=module.vpc.vpc_id
}


###########  instance  ##########
module "ec2-useast1" {
  source = "./modules/useast1/instance"
  pub-useast1-ami =var.pub-useast1-ami
  all-instance-type=var.all-instance-type
  sg_id = module.mysg-useast1.sg_id
  key_name-useast1 = var.key_name-useast1
   public-subnetsID-useast1 = module.vpc-useast1.subnet_ids-public
    private-subnetsID-useast1 = module.vpc-useast1.subnet_ids-private
}
module "ec2-uswest2" {
  source = "./modules/uswest2/instance"
  # sg_id = module.mysg.sg_id
  # subnets = module.vpc.subnet_ids
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
