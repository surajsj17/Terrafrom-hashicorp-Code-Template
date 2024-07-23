variable "aws_instance_type"{
    description = "what type of instance you want to create ?"
    type = string    
    validation {
      condition = var.aws_instance_type=="t2.micro" || var.aws_instance_type=="t3.micro"
      error_message = "Invalid instance type specified. Only t2.micro and t3.micro"
    }
}


# variable "root_block_device_variable" {
#     description = "Configuration for root block device"
#     type = number
#     validation {
#       condition = var.root_block_device_variable<=30 
#       error_message = "Invalid instance size specified"
#     }
# }

variable "root_block_device_variable" {
    description = "Configuration for root block device"
    type = object({
        volume_size = number
        volume_type = string
    })
    default = {
        volume_size = 30
        volume_type = "gp2"
    }
}

variable "names"{
    description = "Names for the resources"
    type = map(string)
    default = {
        instance_name = "example-instance"
}
}