terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.86.0"
    }
  }

  backend "azurerm" {
    resource_group_name   = "ResourceGroup"
    storage_account_name  = "storageaccount"
    container_name        = "terraform-state"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

