#####################################################################
############## GENERAL VALUES THAT DO NOT CHANGE MUCH ###############
##############                  BEGIN                 ###############
#####################################################################
variable "datacenter" {
  description = "The name of the Datacenter that is used"
  default     = "Datacenter"
}

#variable "cluster" {
#  description = "The name of the Cluster that is used"
#}

variable "resource_pool_jbod" {
  description = "The name of the Resource Pool that is used"
  default     = "Not set"
}

variable "folder_name_jbod" {
  description = "The name of the folder the VM is assigned to"
  default     = "Not set"
}

variable "folder_type_jbod" {
  description = "The type of the folder the VM is assigned to"
  default     = "vm"
}

variable "resource_pool_s" {
  description = "The name of the Resource Pool that is used"
  default     = "Not set"
}

variable "folder_name_s" {
  description = "The name of the folder the VM is assigned to"
  default     = "Not set"
}

variable "folder_type_s" {
  description = "The type of the folder the VM is assigned to"
  default     = "vm"
}

variable "vm_annotation" {
  description = "An annotation given to the created VM"
  default     = "Not set"
}

#####################################################################
############## GENERAL VALUES THAT DO NOT CHANGE MUCH ###############
##############                    END                 ###############
#####################################################################



####################################################################
################### CHANGES NEED TO BE MADE HERE ###################
###################            BEGIN             ###################
####################################################################

variable "admin_user" {
  description = "Admin user"
}

variable "admin_password" {
  description = "Admin password"
}

variable "ssh-pub-key" {
  description = "Public SSH key for access"
}

variable "vms" {
  description = "VM specific information"
}
####################################################################
################### CHANGES NEED TO BE MADE HERE ###################
###################             END              ###################
####################################################################