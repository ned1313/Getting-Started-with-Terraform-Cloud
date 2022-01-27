# Using the Private Module Registry

While migrating Team Space Coyote, you found some useful modules you'd like to make available to other groups. You're going to create a private module registry, add the modules, and update a Team Space Coyote's deployment to use the new module location.

## Demos

- Add public modules and providers to the registry
- Create a module with the private registry
- Update the Space Coyote configuration


### Add public modules and providers to the registry

Click on the "Registry" tab at the top of the page. From the providers tab, click on "Search public registry" button. Search for the AWS provider and add it to the registry.

Click on the modules tab, and click on "Search public registry". Search for the `s3-bucket` module. Add the module to the private registry.

### Add the private networking module to the registry



On the VCS connection is complete, click on the "Registry" tab at the top of the page. "Publish" button followed by "Module". Click on the "GitHub" button and select the terraform-aws-s3-bucket repository that you just forked.



### Add private networking module to the registry

The Space Coyote configuration utilizes a local `networking` module for building out the application's networking components including vpc, subnets, route tables, gateways, etc.  This code is not only relevant for the Space Coyote team, but is common networking configuration that will prove valuable for other teams as well.  Therefore the Space Coyote team has offered to publish this as a private module to the registry for other teams to be able to use.

Create a new private github repository named `terraform-aws-networking`:

- Private
- Add a README.md file
- Add a .gitignore template for Terraform

Add the `main.tf`, `variables.tf` and `outputs.tf` of the local networking module to this repository.  Create a `README.md` for the repository that contains the contents of the NetworkREADME.md file in the m9 directory.

After adding the files to the repository, create a new version for the module by creating a Tag with the value `1.0.0`.

In the Terraform Cloud UI, you will need to create an OAuth based VCS connection to GitHub, if you haven't already done so. The GitHub App connection will not work with the private registry.

In the organization settings, go to the **Providers** area of Version control and Add a VCS provider. Select *GitHub.com (Custom)* from the list of providers and walk through the steps to create the connection via OAuth.

Click on the "Registry" tab at the top of the page. "Publish" button followed by "Module". Click on the "GitHub" button and select the `terraform-aws-networking` repository that you just created.

Click on the "Publish module" button.

After the module is completely published, please select version `1.0.0` of the module by clicking `Change` under **Version** in the upper left section of your screen.

### Update the Space Coyote configuration

Update the Space Coyote configuration `main.tf` file to remove the local `networking` module and start using the new `networking` module in the Terraform Cloud private module registry.

```hcl
module "networking" {
  source        = "./networking"
  region        = var.region
  prefix        = var.prefix
  environment   = var.environment
  address_space = "10.0.0.0/16"
  subnet_prefix = "10.0.10.0/24"
}
```

You can copy the module creation code from the "Usage Instructions" section of the module's page in your Private Module Registry.

```hcl
module "networking" {
  source  = "app.terraform.io/example-org-6cde13/networking/aws"
  version = "1.0.0"
  region        = "us-east-1"
  prefix        = "sc"
  environment   = "development"
  address_space = "10.0.0.0/16"
  subnet_prefix = "10.0.10.0/24"
}
```

You can then validate and apply the change by using the new centralized module from Terraform Cloud and remove the local module.

```bash
terraform init
terraform validate
terraform apply
```
