variable "vpc-cidr-useast1" {
  type        = string
  description = "description"
}
variable "uswest2-vpc-cidr" {
  type = string
  description = "cidr for uswest2 is 20.0.0.0/16"
}

variable "subnet-cidr-useast1"{
    type=list(string)
    description="1-subnet"
}
variable "uswest2-PublicSubnet-cidr" {
    type = list(string)
    description = "How many subnets you want you can add here"
  
}
variable "subnet-cidr-private-useast1" {
  type = list(string)
}
variable "uswest2-PrivateSubnet-cidr" {
    type = list(string)
    description = "How many subnets you want you can add here for private subnet"
  
}
variable "availability_zone-subnets" {
  type = string
  description = "us-west-2a is AZ for both public and private subnet"
}

variable "pub-useast1-ami" {
  type = string  
}
variable "uswest2-ami" {
  type = string
  description = "both public and private subnet has same AMI"
}

variable "all-instance-type" {
  type = string
}
variable "all-instance_type" {
  type = string
  description = "all instance are in t2.micro"
}
variable "key_name-useast1" {
  description = "this key can be worked for both the instance in us-east-1"
  type = string
}
variable "peer_region" {
  type = string
  description = "this should be us-west-2"
}
variable "auto_accept" {
  type = bool
  description = "this can be true or false"
}
variable "peer_accept" {
  type = bool
  description = "this is true"
}