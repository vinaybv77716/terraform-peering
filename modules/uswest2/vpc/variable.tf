variable "uswest2-vpc-cidr" {
  type = string
  description = "cidr for uswest2 is 20.0.0.0/16"
}
variable "uswest2-PublicSubnet-cidr" {
    type = list(string)
    description = "How many subnets you want you can add here for public subnet"
  
}
variable "uswest2-PrivateSubnet-cidr" {
    type = list(string)
    description = "How many subnets you want you can add here for private subnet"
  
}
variable "availability_zone-subnets" {
  type = string
  description = "us-west-2a is AZ for both public and private subnet"
}