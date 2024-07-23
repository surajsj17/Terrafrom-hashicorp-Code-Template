variable "vpc_config" {
    description = "taking the cidr and name of the vpc"
    type = object({
        cidr_block = string
        name = string
    })
  
}


variable "subnet_config"{
    description = "add the details"
    type = map(object({
        cidr_block =string
        az = string
        public = optional(bool,false)
    }))
    validation {
      condition = alltrue([for config in var.subnet_config : can(cidrnetmask(config.cidr_block))])
      error_message = "Invalid CIDR block"
    }
}