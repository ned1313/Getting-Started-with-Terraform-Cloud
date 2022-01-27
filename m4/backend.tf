terraform {
  cloud {
    organization = "ORG_NAME"

    workspaces {
      name = "diamonddogs-app-useast1-dev"
    }
  }
}