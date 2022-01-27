# Getting-Started-with-Terraform-Cloud

Exercise files to go with my Pluralsight course [Getting Started with Terraform Cloud](http://www.pluralsight.com/courses/terraform-cloud-getting-started).

## Course Description

As Terraform is adopted across the industry, companies discover they need to collaborate within teams and across the organization. This course will teach you how to use Terraform Cloud to deliver collaboration and automation in a managed environment.

As the use of Terraform expands in an organization, a need arises for **simple collaboration**, **workflow automation**, and a **reliable** and **consistent execution** environment. In this course, Getting Started with Terraform Cloud, you’ll learn to leverage the services and features available in the Terraform Cloud managed service. First, you’ll explore **what Terraform Cloud is** and **how to onboard your organization**. Next, you’ll discover **how to set up an automated workflow that is integrated with versioned source control** . Finally, you’ll learn how to use integrations like **Sentinel** and the **private module registry**. When you’re finished with this course, you’ll have the skills and knowledge of Terraform Cloud needed to successfully migrate your organization.

## Using the exercise files

Unlike some of my other Terraform courses, this course make extensive use of the Terraform Cloud UI. As such, there are going to be less code examples and more directions of what to do to follow along with the demos in the course modules.

Each module directory has a `README.md` file that describes the exercises in that module and general directions for following along. In some cases, this is not a step-by-step guide, but a simple overview. You can watch the Pluralsight videos to see the actual steps.

## Pre-requisites and Expectations

This course is **not going to teach you Terraform**. I expect that you are coming to this course with at least a beginner's level of knowledge on using Terraform, and you are curious about leveraging Terraform Cloud for your organization or personal projects.  It would also be good to be familiar with some basic Git concepts, as we are going to use GitHub for several of the exercises.

You should also have the follow ready to go:

* An AWS account with permissions to create networking and compute resources
* Terraform 1.1 or newer and git installed locally
* A code editor like VS Code
* An email you want to use with Terraform Cloud
* A personal GitHub account you can link to Terraform Cloud

As part of the exercises, you will sign up for a Terraform Cloud account and create a new organization.

## AWS Environment

You will need access to an AWS environment with permissions to create resources in EC2 and S3. I recommend creating a throwaway account just for this course. The exercises have been tested with AWS region `us-east-1`. The input variable `region` has `us-east-1` set as the default, but you can supply a different region if you prefer.

You will need to generate an AWS access key to run through the exercises. You can do this through the IAM console in a browser (*hint*: it's under security credentials for your user) by following the [official AWS docs](https://aws.amazon.com/premiumsupport/knowledge-center/create-access-key/). I'd recommend assigning the `AdministratorAccess` policy to your user to give you permissions to do everything in the account. Also, enable 2FA for the user account!

## Line Endings

An issue I have discovered from time to time is that Terraform doesn't much like the Windows style of ending a line with both a Carriage Return (CR) and a Line Feed (LF), commonly referred to as CRLF.  If you are experiencing strange parsing issues, change the line ending to be Line Feed (LF) only.  In VS Code this can be down by clicking on the CRLF in the lower right corner and changing it to LF. This primarily affects template files or scripts being sent to a Linux machine for processing.

## Money 💰


A gentle reminder about cost.  The course will have you creating resources in AWS.  I have tried to use the [Free-tier](https://aws.amazon.com/free/) eligible items.

In Terraform Cloud, you will start a trial of the Teams & Governance plan on Terraform Cloud, but you do not need to provide any payment information. The trial only lasts for 30 days, after it reverts to the Free plan. I'd recommend completing the course in less than 30 days so you don't lose your progress.

When you complete your exercises, make sure to queue a destroy plan to delete all the infrastructure you've created. You can do so from the Settings area of each Workspace. Select the **Destruction and Deletion** option and click on *Queue destroy plan*.

## Conclusion

I hope you enjoy taking this course as much as I did creating it.  I'd love to hear feedback and suggestions for revisions. Find me on Twitter (@ned1313) or add an issue to this repository.

Thanks and happy automating!

Ned