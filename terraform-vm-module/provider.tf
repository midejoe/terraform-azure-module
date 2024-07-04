terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.86.0"
    }
  }

  backend "azurerm" {
    resource_group_name   = "adewale"
    storage_account_name  = "taplatazgvsaappterraform"
    container_name        = "tf-state-files"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

