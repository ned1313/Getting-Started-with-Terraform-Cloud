# Applying Policy as Code

A major benefit of TFC is access to Sentinel, and your security team is pumped to put some guardrails on what application teams can do. We are going to create a few policies, apply them to the workspace, and show how the checks can fail.

## Demos

- Create Sentinel policies and policy sets
- Apply policy sets to the organization and application workspace
- Test the policies by updated the application code

### Create Sentinel policies and policy sets

First we need a place to store our policies, namely a Policy Set. Sentinel is a policy as code framework, so just like Terraform code we should store Sentinel code in a Version Control System like GitHub.

The policies to be created are in the `m6` directory. Create a policy set in Terraform Cloud by going to the organization settings and clicking on **Policy Sets**. Choose to apply the policy set globally.

Then create policies for each of the files in the `m6` directory, and associate them with the policy set you just created.

### Test the policies by updated the application code

### Manually Run a Plan

Navigate to your diamond dogs development workspaces and queue a plan.

Will see the plan was successful but there was a policy failure. We need to fix our code!

Now, add the **Billing** tag to default tags for the AWS provider in your main.tf file. You can do so directly in GitHub or through the local copy of your repository. Be sure to have the `development` branch checked out.

This time, the Sentinel policy should pass because your EC2 instance now has both tags. Each time you push a change to the development, you'll trigger a new Terraform run. Keep trying until you pass the Sentinel policy check.

## More Policy as Code resources

You can find policy libraries on the [Terraform Registry](https://registry.terraform.io/browse/policies) and [GitHub](https://github.com/hashicorp/terraform-sentinel-policies).
