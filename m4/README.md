# Deploying with the CLI and Terraform Cloud

Let's talk about the various options for deployment with Terraform Cloud. The new application you're using is not in source control at the moment, so we are going to deploy it using the CLI. We'll change that momentarily.

## Demos

- Creating a workspace on TFC with the CLI workflow
- Configuring variable values and environment variables
- Updating the Terraform configuration
- Deploying the configuration with the CLI

### Creating a workspace on TFC with the CLI workflow

Before you deploy your configuration, make a copy of the contents of the `m4` directory to a new directory named `diamond-dogs-app`. This will be the directory we use for the rest of the course.

Workspaces can be created using the UI, CLI, or API. To create a new workspace for the configuration, simply update the `cloud` block in the `terraform.tf` file with your organization name. Save the file and run `terraform init`.

`terraform.tf`

```hcl
terraform {
  cloud {
    organization = "<TFC Organization>"

    workspaces {
      name = "diamonddogs-app-useast1-dev
    }
  }
}
```

While this will create your workspace, it **will not** configure any variables or environment variables. We can do that next.

### Configuring variable values and environment variables

Terraform uses all Terraform and Environment variables for all plans and applies in this workspace. Workspaces using Terraform 0.10.0 or later can also load default values from any \*.auto.tfvars files in the configuration. You may want to use the Terraform Cloud Provider or the variables API to add multiple variables at once.

Terraform requires credentials in order to communicate with your cloud provider's API. These API keys should never be stored directly in your terraform code. We will use Terraform Cloud environment variables to store our sensitive cloud credentials for AWS.

- In the `Variables Set` section of your organization settings create a new variable set named `aws-creds`
- Add a Environment variable named `AWS_ACCESS_KEY_ID` with your AWS Access Key
- Add a second Environment variable named `AWS_SECRET_ACCESS_KEY` with your AWS Secret Key. Be sure to mark this variable as sensitive. Sensitive variables will not be displayed within the environment, and can only be overwritten - not read.

### Configuring variables in the workspace

You will also need to go into the workspace and configure the variables. You can do this by clicking on the `Variables` section in the workspace. You will need to configure the `prefix`, `environment`, and `project` variables.

### Deploying the configuration with the CLI

We can first run a `terraform plan` and then a `terraform apply` to generate our infrastructure. The output of the remote operations will be streamed to our local console.

```bash
terraform plan
```

```bash
terraform apply
```
