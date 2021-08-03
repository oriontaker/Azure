# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "2.46.0"
#     }
#   }
# }

# provider "azurerm" {
#   # tenant_id = "3617ef9b-98b4-40d9-ba43-e1ed6709cf0d"
#   features{}
#   subscription_id = "964df7ca-3ba4-48b6-a695-1ed9db5723f8"
#   # Configuration options
#   #location = "westus"
#   #skip_provider_registration = true
# }

# provider "azurerm" {
#     version = 1.38
#     }

#Cuenta personal con mejores privilegios
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.40.0"
  features {}
}