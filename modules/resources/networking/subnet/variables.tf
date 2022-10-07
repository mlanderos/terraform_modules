
variable "virtualNetworkResourceGroupName" {
  type = string
  #TODO: length 3-63
}

variable "subnet" {
  type = list(object({
    name = string
    resource_group_name = string
    virtual_network_name = string
    address_prefixes = list(string)
    private_endpoint_network_policies_enabled  = bool
    private_link_service_network_policies_enabled = bool
    service_endpoints = optional(list(string))
    service_endpoint_policy_ids = optional(list(string))
    delegation = optional(object({
      name = string
      actions = list(string)
    }))
  }))
}
