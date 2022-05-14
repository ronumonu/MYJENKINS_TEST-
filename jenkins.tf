terraform {
  required_version = ">=1.1.0"
}

provider "azurerm" {

  features {}
  client_id       = "8d83d388-5274-4ece-8cb9-35bcb7bdb717"
  client_secret   = "mZa7Q~FT4J4AJrUnnxKKotxT6iKFqJo.dzhgV"
  tenant_id       = "144f41d9-3a44-420c-a571-64ea858d21d2"
  subscription_id = "ef3deb78-5f0b-43b8-be97-e019bf012778"
}

resource "azurerm_resource_group" "jenkrg" {
  name     = "jenkrg"
  location = "eastus"
}

resource "azurerm_storage_account" "jenksa" {
  name                     = "jenstoreacc"
  resource_group_name      = azurerm_resource_group.jenkrg.name
  location                 = azurerm_resource_group.jenkrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

tags = {
environment = "development"
}
}

resource "azurerm_storage_container" "jenksc" {
  name                  = "jenksc"
  storage_account_name  = azurerm_storage_account.jenksa.name
  container_access_type = "private"
}

resource "azurerm_storage_share" "jenkss" {
  name                 = "jenkss"
  storage_account_name = azurerm_storage_account.jenksa.name
  quota                = 50
}

resource "azurerm_storage_queue" "jenksq" {
  name                 = "jenksq"
  storage_account_name = azurerm_storage_account.jenksa.name
}

resource "azurerm_storage_table" "jenkst" {
  name                 = "jenkst"
  storage_account_name = azurerm_storage_account.jenksa.name
}

resource "azurerm_container_registry" "monu" {
  name                = "monucontainer123"
  resource_group_name = azurerm_resource_group.jenkrg.name
  location            = azurerm_resource_group.jenkrg.location
  sku                 = "Basic"
  admin_enabled       = true
}


