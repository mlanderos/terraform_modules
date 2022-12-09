
output "subnetID" {
  value = azurerm_subnet.subnet.id
}

output "subnetName" {
  value = azurerm_subnet.subnet.name
}

output "subnetResourceGroupName" {
  value = azurerm_subnet.subnet.resource_group_name
}

output "subnetVirtualNetworkName" {
  value = azurerm_subnet.subnet.virtual_network_name
}

output "subnetAddressPrefixes" {
  value = azurerm_subnet.subnet.address_prefixes
}
