
# CREATE AZURE RESOURCE GROUP
resource "azurerm_resource_group" "azure_rg" {
  name     = ${var.resource_group_name}-${var.env_name}
  location = ${var.location}
}


# CREATE AZURE VIRTUAL NETWORK
resource "azurerm_virtual_network" "azure_vn" {
  name                = ${var.vnet_name}-${var.env_name}
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.azure_rg.location
  resource_group_name = azurerm_resource_group.azure_rg.name
}

# CREATE SUBNET WITHIN VNET
resource "azurerm_subnet" "azure_sn" {
  name                 = ${var.subnet_name}-${var.env_name}
  resource_group_name  = azurerm_resource_group.azure_rg.name
  virtual_network_name = azurerm_virtual_network.azure_vn.name
  address_prefixes     = ${var.subnet_cidr}
}

# CREATE APP SERVICE PLAN
resource "azurerm_app_service_plan" "azure_asp" {
  name                = ${var.app_service_plan_name}-${var.env_name}
  location            = ${var.location}
  resource_group_name = azurerm_resource_group.azure_rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "azure_as" {
  name                = ${var.app_service_name}-${var.env_name}
  location            = azurerm_resource_group.azure_rg.location
  resource_group_name = azurerm_resource_group.azure_rg.name
  app_service_plan_id = azurerm_app_service_plan.azure_asp.id

  site_config {
    always_on        = true
    linux_fx_version = "DOCKER|<docker_image>"
  }

  identity {
    type = "SystemAssigned"
  }

  auth_settings {
    enabled = false
  }

  depends_on = [azurerm_subnet.azure_sn]
}

