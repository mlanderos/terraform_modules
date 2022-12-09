variable "subnetName" {
  type = string
}

variable "subnetResourceGroupName" {
  type = string
  #TODO: length 3-63
}

variable "subnetVirtualNetworkName" {
  type = string
}

variable "subnetAddressPrefixes" {
  type = list(string)
}

variable "subnetPrivateEndpointNetworkPoliciesEnabled" {
  type = bool
}

variable "subnetPrivateLinkServiceNetworkPoliciesEnabled" {
  type = bool
}

variable "subnetServiceEndpoints" {
  type = set(string)
  
  nullable = true
  default = []
}

variable "subnetServiceEndpointPolicyIDs" {
  type = set(string)
  
  nullable = true
  #default = []
}

variable "subnetDelegation_Name" {
  type = string
  nullable = true
  default = ""
}

variable "subnetDelegation_Actions" {
  type = list(string)
  nullable = true
  default = []
}
