resource "azurerm_virtual_network" "virtual_network" {
  name                  = var.virtualNetworkName
  location              = var.virtualNetworkLocation
  resource_group_name   = var.virtualNetworkResourceGroupName
  address_space         = var.virtualNetworkAddressSpace
  dns_servers           = var.virtualNetworkDnsServers
  bgp_community         = var.virtualNetworkBgpCommunity

  tags = var.virtualNetworkGroupTags
}
