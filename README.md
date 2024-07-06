# Terraform Azure VM Module

[![Terraform Version](https://img.shields.io/badge/Terraform-v1.0.0%2B-blue)](https://www.terraform.io/downloads.html)

This repository contains a set of Terraform modules for creating Linux and Windows virtual machines in an existing Azure resource group, virtual network, and subnet. The configuration is modular and organized into distinct folders for resource groups, virtual networks, subnets, and virtual machines.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) v1.0.0 or higher

## Folder Structure

```plaintext
terraform-vm-module/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── modules/
│   ├── resource_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   ├── virtual_network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   ├── subnet/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   ├── virtual_machine/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── README.md
