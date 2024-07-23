terraform {
  
}

#number list 

variable "num-list"{
    type = list(number)
    default = [1, 2, 3, 4, 5]
}

variable "person_list" {
    type = list(object({
        name    = string
        age     = number
        address = string
    }))
    default = [
        {name = "Alice", age = 30, address = "123 Main St"},{name = "sigge", age = 28, address = "123 Main St"}]
}

variable "map_list"{
    type = map(string)
    default = {
        "IT" = "Department"
        "QA" = "Student"
    }
}

locals {
    mul = 2*2
    div = 10/2
    add = 10+2
    double = [for num in var.num-list : num*2]
    odd = [for num in var.num-list :num if num%2 != 0]
}
output "name" {
    value = local.odd
}
  
