variable "vpc_parameters" {

  description = "VPC parameters"

  type = map(object({

    cidr_block           = string

    enable_dns_support   = optional(bool, true)

    enable_dns_hostnames = optional(bool, true)

    tags                 = optional(map(string), {})

  }))

  default = {}

}





variable "subnet_parameters" {

  description = "Subnet parameters"

  type = map(object({

    cidr_block = string

    vpc_name   = string

    tags       = optional(map(string), {})

  }))

  default = {}

}



variable "internet_gatway_parameters" {

  description = "Internet gateway parameters"

  type = map(object({

    vpc_name = string

    tags     = optional(map(string), {})

  }))

  default = {}

}





variable "route_table_parameters" {

  description = "Route table parameters"

  type = map(object({

    vpc_name = string

    tags     = optional(map(string), {})

    routes = optional(list(object({

      cidr_block = string

      use_igw    = optional(bool, true)

      gateway_id = string

    })), [])

  }))

  default = {}

}


variable "route_table_association_parameters" {

  description = "Route Table association parameters"

  type = map(object({

    subnet_name = string

    rt_name     = string

  }))

  default = {}

}
variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}
