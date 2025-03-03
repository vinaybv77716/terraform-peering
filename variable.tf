variable "vpc-cidr-useast1" {
  type        = string
  description = "description"
}
variable "subnet-cidr-useast1"{
    type=list(string)
    description="1-subnet"
}
variable "subnet-cidr-private-useast1" {
  type = list(string)
}

variable "pub-useast1-ami" {
  type = string  
}

variable "all-instance-type" {
  type = string
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