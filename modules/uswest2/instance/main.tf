
#public ec2 instance
resource "aws_instance" "public-uswest2" {
  #count = length(var.ec2_names)
  ami           = "ami-00c257e12d6828491"
  instance_type = "t2.micro"
  provider = aws.uswest2
  associate_public_ip_address = true
  #vpc_security_group_ids = [var.sg_id]
  key_name      = "devops"
  subnet_id=aws_subnet.my-subnet-public-uswest2.id
  #availability_zone = "us-east-1"
    tags = {
    Name = "public-uswest2"
  }
}


#private ec2 instance
resource "aws_instance" "private-uswest2" {
  #count = length(var.ec2_names)
  ami           = "ami-00c257e12d6828491"
  instance_type = "t2.micro"
  provider = aws.uswest2
  #vpc_security_group_ids = [var.sg_id]
   key_name      = "devops"
  subnet_id=aws_subnet.my-subnet-private-uswest2.id
  #availability_zone = "us-east-1"
    tags = {
    Name = "private-uswest2"
  }
}

