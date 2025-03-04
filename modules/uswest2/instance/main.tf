
#public ec2 instance
resource "aws_instance" "public-uswest2" {
  count = length(var.ec2_names)
  ami           = var.uswest2-ami
  instance_type = var.all-instance_type
  provider = aws.uswest2
  associate_public_ip_address = true
  vpc_security_group_ids = [var.uswest2-sg]
  key_name      = var.uswest2-key_name
  subnet_id=var.uswest2-PublicSubnet-ID
  #availability_zone = "us-east-1"
    tags = {
    Name = "public-uswest2"
  }
}


#private ec2 instance
resource "aws_instance" "private-uswest2" {
  count = length(var.ec2_names)
  ami           = var.uswest2-ami
  instance_type = var.all-instance_type
  provider = aws.uswest2
  vpc_security_group_ids = [var.uswest2-sg]
   key_name      = var.uswest2-key_name
  subnet_id=var.uswest2-PrivateSubnet-ID
  #availability_zone = "us-east-1"
    tags = {
    Name = "private-uswest2"
  }
}

