# Operating Terraform Cloud for Teams

So far the new application deployment has been really successful. The company wants to migrate other Terraform deployments to TFC. Before you start the migration, you need to provision the proper users, groups, and permissions on TFC.

## Demos

- Create teams with permissions
- Add users to teams and test permissions
- Assign teams to workspaces with permissions

## Create teams with permissions

Teams can have different levels of access to your workspaces. You can invite other users to collaborate on code changes, approvals, and Terraform runs.

1. Go into your organization's General Settings and click on the **Teams** link.
2. Add a team called **org_admins**. Admins should be able to perform all organization-level actions.
3. Add another team called **diamond_dog_devs**. Developers should not have any organization-wide access.
4. Add a third team called **managers**. Managers should also not have any organization-wide access.

## Add users to teams and test permissions

Now that you have created teams and given them workspace access you can invite some users to your organization. Return to your **General Settings** for the organization, and select **Users**. Then click the "Invite a user" button.

Invite a new user with an email you have access to and assign them to the org_admins group. 

## Assign teams to workspaces with permissions

Next, assign access rights to the diamond dogs development workspace. Go into the **Team Access** page of the workspace settings. If you don't see the Team Access link you might need to log out and back into Terraform Cloud.

You'll want to click the "Add team and permissions" button and then click the "Select team" button next to each team to which you wish to grant workspace access. Then click the "Assign permissions" button for the desired permission.

- Give the **diamond_dog_devs** group plan level access.
- Give the **managers** group read level access.

Go into the other workspaces and assign permissions consistently.