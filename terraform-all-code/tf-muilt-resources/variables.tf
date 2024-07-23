variable "instance_name" {
    type = list(object({
        ami = string
        instance_type = string
    }))
}

variable "map_config" {
    type = map(object({
        ami = string
        instance_type = string
}))  
}