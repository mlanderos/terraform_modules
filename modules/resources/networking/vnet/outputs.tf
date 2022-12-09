output "virtualNetworkID" {
  value = azurerm_virtual_network.virtual_network.id
}

output "virtualNetworkName" {
  value = azurerm_virtual_network.virtual_network.name
}

output "virtualNetworkLocation" {
  value = azurerm_virtual_network.virtual_network.location
}

output "virtualNetworkResourceGroupName" {
  value = azurerm_virtual_network.virtual_network.resource_group_name
}

output "virtualNetworkAddressSpace" {
  value = azurerm_virtual_network.virtual_network.address_space
}

output "virtualNetworkGUID" {
  value = azurerm_virtual_network.virtual_network.guid
}
