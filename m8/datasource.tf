terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~>0.50"
    }
  }
}

data "tfe_outputs" "diamond_dogs" {
  organization = "globomantics-tfc"
  workspace = "diamonddogs-app-useast1-dev"
}

output "diamond_dogs_url" {
  value = data.tfe_outputs.diamond_dogs.nonsensitive_values["diamond_dogs_url"]
}