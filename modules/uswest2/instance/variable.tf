variable "uswest2-ami" {
  type = string
  description = "both public and private subnet has same AMI"
}
variable "ec2_names" {
    description = "EC2 names"
    type = list(string)
    default = ["useast1-instances"]
}
variable "all-instance_type" {
  type = string
  description = "all instance are in t2.micro"
}
variable "uswest2-sg" {
  
}
variable "uswest2-key_name" {
  type = string
  description = "devops is the key name which is allready created"
}
variable "uswest2-PublicSubnet-ID" {
  
}
variable "uswest2-PrivateSubnet-ID" {
  
}