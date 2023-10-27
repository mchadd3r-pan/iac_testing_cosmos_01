provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "resourceGroupName"
  location = "East US"
}

resource "azurerm_cosmosdb_account" "example" {
  name                = "cosmosdbaccountname"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  offer_type          = "Standard"

  consistency_policy {
    consistency_level = "BoundedStaleness"
  }

  geo_location {
    location          = azurerm_resource_group.example.location
    failover_priority = 0
  }

  capabilities {
    name = "EnableAggregationPipeline"
  }

  is_virtual_network_filter_enabled = false

  public_network_access_enabled = true

  backup {
    type                = "Periodic"
    interval_in_minutes = 240
    retention_in_hours  = 8
  }
}
