#public ec2 instance
resource "aws_instance" "public-useast1" {
  count = length(var.ec2_names)
  ami           = var.pub-useast1-ami
  instance_type = var.all-instance-type
  provider = aws.useast1
  associate_public_ip_address = true
  vpc_security_group_ids = [var.sg_id]
  key_name      = var.key_name-useast1
  subnet_id=var.public-subnetsID-useast1[count.index]
  #availability_zone = "us-east-1"
    tags = {
    Name = "useast1-public"
  }
}

#private ec2 instance
resource "aws_instance" "private-useast1" {
  count = length(var.ec2_names)
  ami           = var.pub-useast1-ami
  instance_type = var.all-instance-type
  provider = aws.useast1
  vpc_security_group_ids = [var.sg_id]
   key_name      = var.key_name-useast1
  subnet_id=var.private-subnetsID-useast1[count.index]
  #availability_zone = "us-east-1"
    tags = {
    Name = "useast1-private"
  }
}