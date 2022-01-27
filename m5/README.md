# Adopting a Git Workflow

The application is deployed and now you'd like to shift to a VCS style workflow. The new application will be added to a GitHub repo, and then the workspace will be hooked in. The actual deployment shouldn't change at all,

## Demos

- Move application code to a VCS repository
- Migrate to the VCS workflow
- Use the VCS workflow to deploy an update
  - Show how the CLI plan still works

### Move application code to a VCS repository

#### Create a new GitHub repository

You will need a free GitHub.com account for this exercise. We recommend using a personal account. You can sign up or login in to an existing account at https://github.com/

Login to github and create a new repository by navigating to <https://github.com/new>.

Use the following settings for the code repository

- Name: "diamond_dogs"
- Description: Diamond Dogs Wicked Application
- Private repo
- Check "Initialize this repository with a README"
- Add `.gitignore` of type "Terraform"

Once created, clone the repository to your local machine.

```
git clone https://github.com/<YOUR_GIT_HUB_ACCOUNT>/diamond_dogs.git
cd diamond_dogs
```

### Update your Repository and Commit Changes to GitHub

In your repository copy the following configuration files to the `diamond_dogs` directory: `variables.tf`, `main.tf`, `outputs.tf`, `terraform.auto.tfvars`, along with the `files` subdirectory and its contents.

Commit the changes in GitHub.

```
git add .
git commit -m "terraform code update for diamond_dogs app"
git push
```

### Migrate to the VCS workflow

#### Create Terraform Cloud VCS Connection

1. Login to github in one browser tab.
2. Login to Terraform Cloud in another browser tab.
3. Within Terraform Cloud navigate to the settings page
4. Click "VCS Providers" link:

For full instructions follow the **Configuring GitHub Access** section of the Terraform Cloud documentation to connect your GitHub account to your Terraform Organization.

[Configuring GitHub Access](https://www.terraform.io/docs/cloud/vcs/github.html) - https://www.terraform.io/docs/cloud/vcs/github.html

> Note: The process involves several back and forth changes and is documented well in the link.

### Connect Terraform Cloud Workspace to the GitHub `diamond_dogs` repository

1. Navigate to <https://app.terraform.io> and click the diamond dogs workspace
2. Select Settings >> Version Control
3. Click the "Connect to version control"
4. Select the Version Control workflow
5. Click the VCS Connection in the "Source" section.
6. Verify you can see repositories and select the `diamond_dogs` github repository.
7. Select Update VCS Settings
8. Validate that a new Terraform run will occur on the workspace. Confirm and Apply the Terraform run.

### Use the VCS workflow to deploy an update

#### Create a Development and Staging Branch

In the `diamond_dogs` github repository, create a `development` branch from the `main` branch. Also create a `staging` branch from the `main` branch.

Update your Terraform Cloud `diamonddogs-aws-useast1-dev` workspace to point to your `development` branch.

#### Create Terraform Cloud Production and Staging Workspaces

Create a new TFC workspace named `diamonddogs-aws-useast1-prod` that is tied to the `diamond_dogs` github repo by choosing a VCS Control workflow. Set the branch and enable speculative execution.

Repeat this step for the staging environment by creating a new TFC workspace named `diamonddogs-aws-useast1-staging` that is tied to the `diamond_dogs` github repo and specifying the `staging` branch.

Each workspace is setup with it's respected variable for environment and watching that respected branch of our diamond_dogs project.

### Create a Terraform Cloud Variable Set for AWS Authentication

- In the `Settings` tab of your Terraform Cloud Organization go to `Variable sets`.
- Select the `Create Variable set` button
- Give your variable set a name - `AWS Credentials` and description.
- Apply the variable set to all diamond dogs workspaces.
- You can add environment variables for the AWS Credentials
- Add a Environment variable named `AWS_ACCESS_KEY_ID` with your AWS Access Key
- Add a second Environment variable named `AWS_SECRET_ACCESS_KEY ` with your AWS Secret Key. Be sure to mark this variable as sensitive.

Now you can use these AWS credentials on any new workspace you create in Terraform Cloud by adding the variable set to the workspace. While storing cloud credentials is a common use of variable sets, they are not limited to credentials. Variable sets can be utlized for any set of variables that you want to reuse accross workspaces within the organization.

### Update environment specific variables for each Terraform Cloud Workspace

Update the variables for each of the diamond dog Terraform Cloud workspaces for the `environment` variable.

- Navigate to your Terraform Cloud workspaces in the UI.
- Once there, navigate to the `Variables` tab.
- In the `Variables` tab, you can add variables related to the state file that was previously migrated.
- To do this, first select the `+ Add variable` button
- Let's add a Terraform variable named `environment` with a value of `development`

Repeat these same steps for all diamond dogs workspaces specifying the correlating environment value for each.  Validate that the application deploys with the respective settings by triggering a Manual apply >> `Actions >> Start new plan`

### Version Control Branching and Terraform Cloud Workspaces

We will be using GitHub to promote a change to our app through Development into Stage and then into Production.

Let's look how a change promotion would look in this configuration we outlined. We are going to start in our "Development" environment and move, or promote, that change to our other environments. Make sure you have both GitHub and Terraform Cloud web pages up. We will start in GitHub.

#### Code Promotion

Let's look how a change promotion would look in this configuration we outlined. We are going to start in our "Development" environment and move, or promote, that change to our other environments. Make sure you have both GitHub and Terraform Cloud web pages up. We will start in GitHub.

1. Select the `diamond_dogs` project, if you are not already there.
2. From the branches list (pulldown menu that says main), choose `development`
3. Select the `Files` folder and the `deploy_app.sh`.
4. Click on the blue `Edit` button. We will just use the GitHub web editor for simplicity.
5. On line 14, add a message after the "Welcome" message. `The Diamond Dogs have struck again.` 
6. Add a "Commit message" below that describes your change.
7. When you're done click on `Commit Changes`
8. Navigate back out to Terraform Cloud. You should see that your diamond dogs development workspace is running.
9. Approve the change by viewing the run.
9. Refresh your Diamond Dogs Development web page to confirm that your updates are now displayed.

Now that we have our change in our development environment and we did our testing to confirm our application is functional, let's promote this
change to our stage environment.

1. Navigate back to GitHub. You should still be on the development branch viewing the `deploy_app.sh` file that we edited. Click on the
   `Pull requests` option. We will be merging our changes we made in the development branch to our staging branch.
2. Select the `Compare & pull request` select `Change branches`. Our source branch will default to "development". Change the target branch to
   `staging` and select `Create pull request`
3. Update the Title to `Promote to Stage` and add a short description of your change.
4. For "Assignee" select `Assign to me`. We currently do not have users and groups setup in our environment but in a real world scenario
   we can put security controls around this approval process.
5. On the bottom of the page you can view what files and lines in those files are different between the development and stage branches. These are the changes that will be merged into our target branch.
6. Select `Create pull request`. We now have an opened a pull request. In our lab, approvals are optional but we could require multiple approvers before any changes get applied. We could deny the request and put a comment with details regarding why we denied it.
7. Click on the `Show all checks` next to the green check-mark.
8. Open the `Details` link in a new tab. As a pull request reviewer, you can use this to review the Terraform plan that was ran by the GitHub pipeline within the diamond dogs staging workspace.

We peer reviewed the changes everything looks good. Now go back to the tab we left open with our merge request and select the green `Merge pull request` button and `Confirm merge`.

Notice that another pipeline was started under where the merge button was. Right click on this new pipeline and open it in a new tab. You can use the external pipeline to link out to Terraform Cloud to review the apply. We could have also been watching the Terraform Cloud workspace list to see our workspaces auto apply from our merge request inside the diamond dogs staging workspace.

You can open the stage URL of our Diamond Dogs app to confirm that our changes have been added.

The process to promote our change into our production environment would be identical and the environments are isolated so changes in the development branch have no impact to the production / main branch.
