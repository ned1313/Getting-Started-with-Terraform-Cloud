# Migrating to Terraform Cloud

Team Space Coyote is ready to migrate their application to Terraform Cloud. You are going to help them create workspaces, set up a CLI workflow, and migrate the state of the existing deployment.

## Demos

- Create the Space Coyote deployment to test migration
- Create the necessary resources in Terraform Cloud
- Update and migrate the Space Coyote deployment

### Create the Space Coyote deployment to test migration

First copy the `space_coyote` directory from the `m8` directory to a new directory named `space-coyote-app`. This will be the directory we use for the rest of the course.

Deploy the Space Coyote application by initializing terraform, validating the code and executing an apply.

```bash
# Set AWS credentials or use existing profile
terraform init
terraform validate
terraform apply
```

You can confirm the application has been deployed by browsing to the `space_coyote_url` and that terraform is storing the state of the environment locally inside a `terraform.tfstate` file.

```bash
terraform show
```

### Create the necessary resources in Terraform Cloud

Team Space Coyote is ready to migrate their application to Terraform Cloud. You are going to help them create workspaces, set up a CLI workflow, and migrate the state of the existing deployment.

To migrate the application to Terraform Cloud, create a `backend.tf` file with the following code, replacing the `YOURORGANIZATION` placeholder with your Terraform Cloud organization name.

`backend.tf`

```hcl
terraform {
  cloud {
    organization = "YOURORGANIZATION"

    workspaces {
      tags = ["spacecoyote","apps"]
    }
  }
}
```

Validate the code is correct with a `terraform validate`

## Update and migrate the Space Coyote deployment

Begin the migration to Terraform Cloud by issuing a `terraform init` and proceeding to answer the migration questions presented. The new workspace name should be `spacecoyote-app-useast1-dev`.

After migration you should see a new state file on the "States" tab of your `spacecoyote-app-useast1-dev` Terraform Cloud workspace.

You can confirm that the output of a `terraform show` matches the output of the same command before the migration. Once the migration is complete delete the local terraform.tfstate file by running `rm terraform.tfstate`.

### Secure Space Coyote variables within Terraform Cloud

Within Terraform Cloud create the required variables for the Space Coyote application.  These can be found in the `terraform.tfvars` files.

```hcl
prefix      = "sc"
project     = "space_coyote"
environment = "development"
billing    = "314159"
```

Next, update the variable set from the previous modules to allow the new workspace access.

Finally, create the space_coyote_devs team and grant it write access to the workspace.

Validate that all the required migration steps have been satisfied by running a successful `terraform apply`.

Congratulations!!!  Now all future changes to Terraform will be executed against Terraform Cloud, and the features of Terraform Cloud can be leveraged fully by the Space Coyote application.

### Query information from Diamond Dogs TFC Workspaces

Now that both the Diamond Dogs and Space Coyote state is stored within Terraform Cloud, the Space Coyote team has decided that they would like to include a link to the Diamond Dog's application.  How can they do this in an automated fashion?

They can use both the `tfe_outputs` data source and Terraform Cloud Run Triggers.

### Allow state access for SC

We are going to be pulling information from the Diamond Dogs outputs through the `tfe_outputs` data source. Before we trigger a run with our updated configuration, we need to grant the Space Coyote workspace access to the Diamond Dogs dev outputs.

In the General settings of the Diamond Dogs development workspace, update the **Remote state sharing** setting to share the remote state with the Space Coyote development workspace and click on save settings.

### Terraform Cloud Run Triggers

Terraform Cloud provides a way to connect your workspace to one or more workspaces within your organization, known as "source workspaces". These connections, called run triggers, allow runs to queue automatically in your workspace on successful apply of runs in any of the source workspaces.

We can now set our Space Coyote development workspace to automatically perform an run and update whenever the Diamond Dog's development workspace has a successful run.

Select the `Settings` of the Space Coyote dev workspace and choose `Run Triggers`.  Specify the `Source Workspace` as Diamond Dogs Dev workspace, and select `Add workspace`.  Now anytime the source workspaces has a successful apply the Space Coyote workspace will trigger an automatic run.  

To see this in action, change the billable value in the variables, and trigger a Terraform run in the Diamond Dogs dev workspace and then notice that after the apply is complete an automatic run will be triggered inside the Space Coyote dev workspace.  You can view the metadata of this run within the Space Coyote workspace and validate that the run was trigger from the source workspace.

This will ensure that the Diamond Dog's url output is always up to date within the Space Coyote message because it will pull the remote state of that workspace anytime there is a change in the Diamond Dog's workspace.
