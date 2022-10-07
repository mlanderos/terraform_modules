variable "virtualNetworkName" {
  type        = string
  description = "The Name of the virtual network.  This is appended to the standard naming convention."
  default     = null
}

variable "virtualNetworkLocation" {
  type = string
}

variable "virtualNetworkResourceGroupName" {
  type = string
  #TODO: length 3-63
}

variable "virtualNetworkAddressSpace" {
  type        = list(string)
  description = "Virtual Network Address Space(s)"
  default     = null
}

variable "virtualNetworkDnsServers" {
  type = list(string)
  description = "A list of DNS servers."
  sensitive = false
  default = ["168.63.129.16"]
}

variable "virtualNetworkBgpCommunity" {
  type        = string
  description = "BGP Community Information"
  default     = null
  sensitive   = false
}

variable "virtualNetworkGroupTags" {
  type = map(string)
}
