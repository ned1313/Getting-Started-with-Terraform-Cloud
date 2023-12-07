terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~>0.50"
    }
  }
}

data "tfe_outputs" "diamond_dogs" {
  organization = "YOUR_ORGANIZATION"
  workspace    = "DIAMOND_DOGS_WORKSPACE_NAME"
}

output "diamond_dogs_url" {
  value = data.tfe_outputs.diamond_dogs.nonsensitive_values["diamond_dogs_url"]
}