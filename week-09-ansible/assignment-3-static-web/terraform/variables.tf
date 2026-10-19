variable "location" {
  description = "Azure region"
  type        = string
  default     = "South India"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "rg-static-web"
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B2ats_v2"
}

variable "admin_username" {
  description = "Linux administrator username"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default     = "~/.ssh/azure-ansible.pub"
}
