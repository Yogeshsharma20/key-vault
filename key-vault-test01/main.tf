data "azurerm_client_config" "current" {
}


resource "azurerm_key_vault" "Key_vault" {
  name                        = "Test-Keyvault-yogesh"
  location                    = "East US"
  resource_group_name         = "rg-crime_master-gogo"
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled    = false
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "d9e1ac92-8165-489a-9904-ab11409d13a2"

    key_permissions = [
      "Get", 
    ]

    secret_permissions = [
      "Get", 
    ]

    storage_permissions = [
      "Get",
    ]
  }
}


resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
resource "azurerm_key_vault_secret" "tf_secret" {
  name         = "secret-sauce"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.Key_vault.id
}