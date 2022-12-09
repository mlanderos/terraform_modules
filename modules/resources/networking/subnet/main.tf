
resource "azurerm_subnet" "subnet" {
  name                                          = var.subnetName
  resource_group_name                           = var.subnetResourceGroupName
  virtual_network_name                          = var.subnetVirtualNetworkName
  address_prefixes                              = var.subnetAddressPrefixes
  private_endpoint_network_policies_enabled     = var.subnetPrivateEndpointNetworkPoliciesEnabled
  private_link_service_network_policies_enabled = var.subnetPrivateLinkServiceNetworkPoliciesEnabled
  service_endpoints                             = var.subnetServiceEndpoints
  service_endpoint_policy_ids                   = var.subnetServiceEndpointPolicyIDs
  
    dynamic "delegation" {
    for_each = var.subnetDelegation_Name != "" ? [1] : []
    content {
      name = "delegation"
      service_delegation {
        name    = var.subnetDelegation_Name
        actions = var.subnetDelegation_Actions
      }
    }
  } 
}
