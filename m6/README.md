# Applying Policy as Code

A major benefit of TFC is access to Sentinel, and your security team is pumped to put some guardrails on what application teams can do. We are going to create a few policies, apply them to the workspace, and show how the checks can fail.

## Demos

- Create Sentinel policies and policy sets
- Apply policy sets to the organization and application workspace
- Test the policies by updated the application code

### Create Sentinel policies and policy sets

First we need a place to store our policies, namely a Policy Set. Sentinel is a policy as code framework, so just like Terraform code we should store Sentinel code in a Version Control System like GitHub.

Create a fork of this GitHub repo, which contains several Sentinel Policy Sets that you can use in your own organization. Use the **Fork** button in the upper right corner of the screen to create your own copy into your GitHub account.

### Apply policy sets to the organization and application workspace

1. Go into the **Organization Settings** for your training organization and click on **Policy Sets**.
2. Use the **Connect a new policy set** button to connect your new GitHub repo to your organization. Remember, the repository is named **Getting-Started-with-Terraform-Cloud**.
3. Under **Name** enter "AWS-Global-Policies"
4. Under **Description** you can enter "Sentinel Policies for our AWS resources".
5. In the **More Options** menu set the **Policies Path** to `/m6/global`. This tells Terraform Cloud to use the AWS specific policies that are stored in the repo.
6. Leave everything else at its default setting and click on the **Connect policy set** button at the bottom of the page.

### Test the policies by updated the application code

### Manually Run a Plan

Navigate to your diamond dogs development workspces and queue a plan.

Will see the plan was successful but there was a policy failure, however the option to Apply is still available. **Discard the plan.** 

Now, add the **Billable** tag to the aws_instance resource or the default tags for the AWS provider in your main.tf file with and run these commands to push the change to your repository:

```
git add .
git commit -m "Added the required tags"
git push
```

This time, the Sentinel policy should pass because your EC2 instance now has both tags. Each time you push a change to master, you'll trigger a new Terraform run. Keep trying until you pass the Sentinel policy check.

### Apply policy sets application workspace

1. Go into the **Organization Settings** for your training organization and click on **Policy Sets**.
2. Use the **Connect a new policy set** button to connect your new GitHub repo to your organization. Remember, the repository is named **Getting-Started-with-Terraform-Cloud**.
3. Under **Name** enter "AWS-Development-Policies"
4. Under **Description** you can enter "Sentinel Policies for Development AWS resources".
5. In the **More Options** menu set the **Policies Path** to `/m6/dev`. This tells Terraform Cloud to use the AWS specific policies that are stored in the repo.
6. Select "Policies enforced on selected workspaces" and Add the diamond dogs development workspace with an `Add workspace`
7. Leave everything else at its default setting and click on the **Connect policy set** button at the bottom of the page.

#### Update the instance size for a development resource

Navigate to your diamond dogs development workspace and create a `instance_type` variable value and set it to `t2.medium`

### Manually Run a Plan

Queue a plan in the diamond dogs development workspace.

### Review the Plan

Will see the plan was successful but there was a policy failure because of the instance_type is not within regulation. Update the `instance_type` variable for the workspace to be in compliance.
