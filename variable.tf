variable "vpc_cidr_block" {
  type = string
}


variable "pri-nw-config" {
  type = map(object({
    cidr_block               = string
    az                       = string
    associated_public_subnet = string
    eks                      = bool
  }))

  default = {
    "private-1" = {
      cidr_block               = "10.20.1.0/26"
      az                       = "us-east-1a"
      associated_public_subnet = "public-1"
      eks                      = true
    },
    "private-2" = {
      cidr_block               = "10.20.2.0/26"
      az                       = "us-east-1b"
      associated_public_subnet = "public-2"
      eks                      = true
    }
  }
}

locals {
  private_nested_config = flatten([
    for name, config in var.pri-nw-config : [
      {
        name                     = name
        cidr_block               = config.cidr_block
        az                       = config.az
        associated_public_subnet = config.associated_public_subnet
        eks                      = config.eks
      }
    ]
  ])
}

variable "pub-nw-config" {
  type = map(object({
    cidr_block = string
    az         = string
    nat_gw     = bool
    eks        = bool
  }))

  default = {
    "public-1" = {
      cidr_block = "10.20.3.0/26"
      az         = "us-east-1a"
      nat_gw     = true
      eks        = true
    },
    "public-2" = {
      cidr_block = "10.20.4.0/26"
      az         = "us-east-1b"
      nat_gw     = true
      eks        = true
    }

  }
}

locals {
  public_nested_config = flatten([
    for name, config in var.pub-nw-config : [
      {
        name       = name
        cidr_block = config.cidr_block
        az         = config.az
        nat_gw     = config.nat_gw
        eks        = config.eks
      }
    ]
  ])
}


variable "region" {
  type = string

}

variable "az" {
  type = list(string)

}

variable "env" {
  type = string
}


variable "internal_ip_range" {
  type = string
}

variable "EKS_CLUSTER_NAME" {
  type = string
}