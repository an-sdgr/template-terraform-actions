# The standard is to place provider configuration in 'provider.tf'
# However, this always bothered me as the terraform configuration block
# Isn't necessarily restricted to provider configuration
terraform {
  cloud {}
  required_providers {
    tfcoremock = {
      source  = "hashicorp/tfcoremock"
      version = "0.1.2"
    }
  }
}
