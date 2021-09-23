# Modules definition for creating Key Vault's resource group
module "resource_group" {
 source                              = "../../../common-modules/resource-group"
 resource_group_name                 = var.resource_group_name
 region                              = var.region
 tagvalue                            = var.tagvalue
 environment                         = var.environment
}



# Module to create Vnet for our project
module "projectvnet" {
  source                                  = "../vnet"
  resource_group_name                     = module.resource_group.resource_group_name
  vnet_enable                             = var.vnet_enable
  region                                  = var.region
  vnet_name                               = var.vnet_name
  vnet_address                            = var.vnet_address
  tagvalue                                = var.tagvalue
  environment                             = var.environment
 }

# Module to create Subnets
module "projectsubnet" {
  source                                  = "../subnet"
  resource_group_name                     = module.resource_group.resource_group_name
  subnet_count                            = var.subnet_count
  vnet_name                               = module.projectvnet.vnet_name[0]
  subnet_names                            = var.subnet_names
  subnet_range                            = var.subnet_range
  environment                             = var.environment
  service_endpoints                       = var.service_endpoints
  service_endpoints_enable                 = var.service_endpoints_enable
 }


# Module for routatable association with managment subnet
module "rt_association_Management_subnet" {
    source                                = "../routetable-association"
    rt_enable                             = var.rt_enable
    subnet_count                          = var.management_subnet_enable
    subnet_id                             = module.projectsubnet_management.subnet_id
    rt_id                                 = module.projectrt_management.rt_id
 }


# Module to create ER Subnet
module "projectsubnet_er" {
  source                                  = "../subnet"
  resource_group_name                     = module.resource_group.resource_group_name
  subnet_count                            = var.er_subnet_enable
  vnet_name                               = module.projectvnet.vnet_name[0]
  subnet_names                            = var.subnet_er
  subnet_range                            = var.subnet_er_range
  environment                             = var.environment
  }


# Module to create Management subnet
module "projectsubnet_management" {
  source                                  = "../subnet"
  resource_group_name                     = module.resource_group.resource_group_name
  subnet_count                            = var.management_subnet_enable
  vnet_name                               = module.projectvnet.vnet_name[0]
  subnet_names                            = var.subnet_management
  subnet_range                            = var.subnet_management_range
  environment                             = var.environment
 }

