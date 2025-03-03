variable "ec2_names" {
    description = "EC2 names"
    type = list(string)
    default = ["useast1-public"]
}

variable "pub-useast1-ami" {
  description = "this is ami id for public instance in useast1"
  type = string
}

variable "all-instance-type" {
  type = string
  description = "t2.micro is default for all instance"
}

variable "sg_id" {
    description = "SG ID for EC2"
  type = string
}

variable "key_name-useast1" {
  description = "this key can be worked for both the instance in us-east-1"
  type = string
}

variable "public-subnetsID-useast1" {
  description = "Subnets for EC2"
  type = list(string)
}

variable "private-subnetsID-useast1" {
  description = "Subnets for EC2"
  type = list(string)
}