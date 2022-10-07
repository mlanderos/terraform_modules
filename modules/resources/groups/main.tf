# contains important resource definitions and configurations

resource "azurerm_resource_group" "resourceGroup" {
  name = var.resourceGroupName
  location = var.resourceGroupLocation

  tags = var.resourceGroupTags
}
