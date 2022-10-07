
output "subnetID" {
  value = {
    for k,v in azurerm_subnet.subnet: k => v.id
  }
}

output "subnetName" {
  value = {
    for k,v in azurerm_subnet.subnet: k => v.name
  }
}

output "subnetResourceGroupName" {
  value = {
    for k,v in azurerm_subnet.subnet: k => v.resource_group_name
  } 
}

output "subnetVirtualNetworkName" {
  value = {
    for k,v in azurerm_subnet.subnet: k => v.virtual_network_name
  } 
}

output "subnetAddressPrefixes" {
  value = {
    for k,v in azurerm_subnet.subnet: k => v.address_prefixes
  } 
}
