# Configuring Your Organization and Workspaces

We need to sign up for an HCP Account and then Terraform Cloud and create an organization and workspace for the new application. We can use the process to take a brief tour and get our local Terraform client configured to use TFC.

## Demos

- Signing up a new organization for Terraform Cloud
- Tour of the user interface.
- Configuring the Terraform CLI to work with TFC.

## Signing up a new organization for Terraform Cloud

Let's start with setting up an HCP Account and use that to connect to Terraform Cloud. We recommend not using any production Terraform Cloud accounts for this course.

Click on the link below and create an account if you do not already have one. Please be sure to validate your email address.

[https://portal.cloud.hashicorp.com/sign-up](https://portal.cloud.hashicorp.com/sign-up)

After you have validated your email you will be taken to the HCP portal. From there, you can click on the Terraform Cloud service and link your HCP account to Terraform Cloud. Then you can create an organization.

The organization name needs to be unique so be creative.

## Configuring the Terraform CLI to work with TFC

Now we are going to create an API token for Terraform Cloud. From your terminal run the following command

```
terraform login
```

When prompted, enter `yes` to proceed. Click on the URL provided. This will forward you to Terraform Cloud to create an API token. 

Copy the token string and paste that at the "Token for app.terraform.io" prompt.

If the token was entered successfully you should see the following:

```bash
Retrieved token for user tfcuser

---

                                          -
                                          -----                           -
                                          ---------                      --
                                          ---------  -                -----
                                           ---------  ------        -------
                                             -------  ---------  ----------
                                                ----  ---------- ----------
                                                  --  ---------- ----------

Welcome to Terraform Cloud! - ---------- -------

---

## Documentation: terraform.io/docs/cloud -------- -

---

---

---

New to TFC? Follow these steps to instantly apply an example configuration:

$ git clone https://github.com/hashicorp/tfc-getting-started.git
$ cd tfc-getting-started
$ scripts/setup.sh
```
