# Variable Declaration for Resource group name
variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
  default = "networking"
}


# Variable Declaration for Region/Location
variable "location" {
  description = "The location/region where resources is created. Changing this forces a new resource to be created."
  default = ""
}

