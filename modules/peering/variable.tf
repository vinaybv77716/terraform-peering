variable "vpc_id-useast1" {
  type = string
  description = "this is 1st vpc vpc_id"
}

variable "vpc_id-uswest2" {
  type = string
  description = "this is 2st vpc vpc_id"
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
variable "route_table_id-public" {
  type = string
  description = "output of vpc useast1"
}
variable "route_table_id-private" {
  type = string
  description = "output of vpc useast1"
}