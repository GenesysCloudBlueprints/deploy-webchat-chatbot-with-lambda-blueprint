---
title: Build a web chat-based chatbot calling an AWS Lambda via a Genesys Cloud Data Action
author: john.carnell
indextype: blueprint
icon: blueprint
image: images/overview.png
category: 5
summary: |
  This Genesys Cloud Developer blueprint demonstrates how to build a web chat-based chatbot using Genesys Cloud's web chat and bot capabilities and integrating that chatbot with an AWS lambda.
---
## Scenario

An organization is interested in building a chatbot that allows customers to check the status of an order they have placed. The goal of this chatbot is to:

* **Implement a chatbot that can be used across multiple contact center channels.** - The development team wants to quickly stand up a bot flow that they can use to process inbound chats. However, they want to leverage this flow in a non-channel-specific way to integrate it with a voice channel in the future.

* **Implement a chatbot on their company website.** - The company wants to be able to deliver the chatbot on its company website with minimal coding effort.

* **Integrate their chatbot with an AWS lambda to look up the order status for a customer** - The organization already has an AWS lambda that they use for looking up customer order information. They want to reuse this lambda in their chatbot to speed up overall delivery velocity and promote reuse.

## Solution

The organization can leverage Genesys Cloud Architect bot flows, inbound chat, data actions and chat widget to build their chatbot. These Genesys Cloud components can provide the following capabilities.

1. **Bot Flow**. This Genesys Cloud Architect flow allows you to define the words and intents associated with speech and text detection in a chat or voice bot. 
2. **Inbound Chat Flow**. This Genesys Cloud Architect flow builds on top of a Genesys Cloud Bot flow. The inbound chat flow provides the integration and routing layer to get the customer to the right information or people.  
3. **Data Action**. A Genesys Cloud Data Action provides the integration point out to a third-party REST web service or AWS lambda.
4. **Chat Widget**. The Genesys Cloud Chat widget allows you to configure and create a JavaScript chat widget that can deploy to an organization's website.

All the Genesys Cloud components and the AWS lambda are used to look up a customer's order status. All the components used in this solution can be deployed using Terraform, the Terraform AWS provider and the Terraform Genesys Cloud CX as Code provider. The diagram below illustrates all the Terraform providers, and the resources they create.  

![Build a web chat-based chatbot calling an AWS Lambda via a Genesys Cloud Data Action](images/overview.png "Build a web chat-based chatbot calling an AWS Lambda via a Genesys Cloud Data Action")

## Contents

* [Solution components](#solution-components "Goes to the Solution components section")
* [Software development kits](#software-development-kits "Goes to the Software development kits section")
* [Prerequisites](#prerequisites "Goes to the Prerequisites section")
* [Implementation steps](#implementation-steps "Goes to the Implementation steps section")
* [Additional resources](#additional-resources "Goes to the Additional resources section")


:::{"alert":"info","title":"Important Information","collapsible":false,"autoCollapse":false}
While Genesys still support the Web Chat capability, Genesys is investing in its next generation
messaging platform, [Web Messaging](/api/digital/webmessaging/).

Only leverage this blueprint if you have existing Web Chat deployments. Otherwise, you should view the [sister blueprint](https://github.com/GenesysCloudBlueprints/deploy-webmessaging-chatbot-with-lambda-blueprint) that delivers the exact solution, except uses Web Messaging.
:::

This Genesys Cloud Developer blueprint demonstrates how to build a chatbot using Genesys Cloud's Web chat capabilities and integrating that chatbot with an AWS lambda. 

This blueprint demonstrates how to:

* Build a bot Genesys Cloud Architect flow leverages machine learning to communicate intelligently with a customer.
* Build an inbound chat Genesys Cloud Architect flow that integrates with the bot flow. 
* Expose the chatbot for consumption using the Genesys Cloud Web Chat widget.
* Integrate an AWS Lambda in the inbound chat flow using a Genesys Cloud Data Action.
* Deploy both the AWS Lambda, all AWS IAM roles, and CX as Code components, all from within a single Terraform/CX as Code project.

## Solution components

* **Genesys Cloud** - A suite of Genesys Cloud services for enterprise-grade communications, collaboration, and contact center management. In this solution, you use an Architect bot flow, Architect chat flow, and a Genesys Cloud integration, data action, queues, and chat widget.
* **Archy** - A Genesys Cloud command-line tool for building and managing Architect flows.
* **CX as Code** - A Genesys Cloud Terraform provider that provides an interface for declaring core Genesys Cloud objects.
* **AWS Terraform Provider** - An Amazon-supported Terraform provides an interface for declaring Amazon Web Services infrastructure.
* **AWS Lambda** - A serverless computing service for running code without creating or maintaining the underlying infrastructure. For more information see, [AWS Lambda](https://aws.amazon.com/translate/ "Opens the Amazon AWS Translate page") on the Amazon featured services website. 

## Prerequisites

### Specialized knowledge

* Administrator-level knowledge of Genesys Cloud
* AWS Cloud Practitioner-level knowledge of AWS IAM and AWS Lambda
* Experience with Terraform

## Software development kits

There are no required SDKs needed for this project. This project contains everything to deploy the blueprint, including a pre-compiled version of the AWS lambda. 

If you want changes to the AWS lambda, the source code can be found in the `lambda-orderstatus` directory. To build this lambda, you need the Golang SDK. The latest Golang version of Golang can be found [The Go programming language](https://go.dev/ "Goes to the Go programming language page"). To rebuild the lambda from the source code:

1. Have the Golang SDK installed on the machine.
2. Change to the `blueprint/lambda-orderstatus directory.
3. Issue this build command: `GOOS=linux go build -o bin/main ./...`

This builds a Linux executable called `main` in the `bin` directory.  The CX as Code scripts compress this executable and deploy the zip as part of the AWS Lambda deploy via Terraform.

:::primary: **NOTE**: The executable built above onlys run on Linux. Golang allows you build Linux executables on Windows and OS/X, but you will not be able to run them locally.**
:::

### Genesys Cloud account

* A Genesys Cloud license. For more information see, [Genesys Cloud Pricing](https://www.genesys.com/pricing "Goes to the Genesys Cloud pricing page") in the Genesys Cloud website. For this project, you need at least a Genesys Cloud Engage 3 and botFlows license for your organization.
* Master Admin role. For more information see, [Roles and permissions overview](https://help.mypurecloud.com/?p=24360 "Goes to the Roles and permissions overview article") in the Genesys Cloud Resource Center.
* Archy. For more information see, [Welcome to Archy](https://developer.genesys.cloud/devapps/archy/ "Goes to the Welcome to Archy page") in the Genesys Cloud Developer Center.
* CX as Code. For more information see, [CX as Code](https://developer.genesys.cloud/api/rest/CX-as-Code/ "Goes to the CX as Code page") in the Genesys Cloud Developer Center.

### AWS account

* An administrator account with permissions to access these services:
  * AWS Identity and Access Management (IAM)
  * AWS Lambda
  * AWS credentials. For more information about setting up your AWS credentials on your local machine, see [About credential providers](https://docs.aws.amazon.com/sdkref/latest/guide/creds-config-files.html "Goes to the About credential providers page") on the AWS page.

### Development tools running in your local environment

* Terraform (the latest binary). For more information see, [Download Terraform](https://www.terraform.io/downloads.html "Goes to the Download Terraform page") on the Terraform website.
* Golang 1.16 or higher. For more information see, [Download Golang](https://go.dev/ "Goes to the Go programming languge page") on the Go website. 
* Archy (the latest version). Archy is Genesys Cloud's command line to deploy Genesys Cloud Architect Flows. For more information see,

  * [Archy Documentation](/devapps/archy/ "Archy Documentation")
  * [Installing and Configuring Archy - Video](https://www.youtube.com/watch?v=fOI_vq3PnM8 "Installing and configuring Archy")
  * [Exporting flows with Archy - Video](https://www.youtube.com/watch?v=QAmkM_agsrY "Exporting flows with Archy")
  * [Importing flows with Archy - Video](https://www.youtube.com/watch?v=3NwGJ9X1O0s "Importing flows with Archy")

## Implementation steps

1. [Clone the GitHub repository](#clone-the-github-repository "Goes to the Clone the GitHub repository section")
2. [Setup your AWS and Genesys Cloud Credentials](#setup-your-aws-and-genesys-cloud-credentials "Goes to the Setup your AWS and Genesys Cloud Credentials section")
3. [Configure your Terraform build ](#configure-your-terraform-build "Goes to the Configure your Terraform build")
4. [Run Terraform](#run-terraform "Goes to the Run Terraform section")
5. [Test the deployment](#test-the-deployment "Goes to the Test the deployment section")

### Clone the GitHub repository

Clone the GitHub repository [deploy-webchat-chatbot-with-lambda-blueprint](https://github.com/GenesysCloudBlueprints/deploy-webchat-chatbot-with-lambda-blueprint "Goes to the GitHub repository") on your local machine. The `deploy-webchat-chatbot-with-lambda-blueprint/blueprint` folder includes solution-specific scripts and files in these subfolders:
* `lambda-orderstatus` - Source code for the example lambda used in this application.
* `terraform` - All Terraform files and Architect flows to deploy the application.


### Setup your AWS and Genesys Cloud Credentials

To run this project using the AWS and Genesys Cloud Terraform provider, you must open a terminal window, set the following environment variables, and run Terraform in the window where the environment variables are set. The following environment variables are set.

 * `GENESYSCLOUD_OAUTHCLIENT_ID` - This is the Genesys Cloud client credential grant Id that CX as Code executes against. 
 * `GENESYSCLOUD_OAUTHCLIENT_SECRET` - This is the Genesys Cloud client credential secret that CX as Code executes against. 
 * `GENESYSCLOUD_REGION` - This is the Genesys Cloud region in your organization.
 * `AWS_ACCESS_KEY_ID` - This is the AWS Access Key you must set up in your Amazon account to allow the AWS Terraform provider to act against your account.
 * `AWS_SECRET_ACCESS_KEY` - This is the AWS Secret you must set up in your Amazon account to allow the AWS Terraform provider to act against your account.

**Note:** For this project, the Genesys Cloud OAuth Client was given the master admin role. 

### Configure your Terraform build

Several values are specific to your AWS region and Genesys Cloud organization. These values can be defined in the `blueprint/terraform/dev.auto.tfvars` file.

The values that must be set include:

* `organizationId` - Your Genesys Cloud organization id.
* `awsRegion` - The AWS region (e.g us-east-1, us-west-2) that you are going to deploy the target Lambda to.
* `environment` - This is a free-form field that is combined with the prefix value to define the name of various AWS and Genesys Cloud artifacts. For example, if you set the environment name to be `dev` and the prefix to be `dude-order-status` your AWS Lambda, IAM roles, Genesys Cloud Integration and Data Actions will all begin with `dev-dude-order-status`.
* `prefix`- This a free-form field that will be combined with the environment value to define the name of various AWS and Genesys Cloud artifacts.

The following is an example of the `dev.auto.tfvars` used by the author of this blueprint.

```
organizationId = "011a0480-9a1e-4da9-8cdd-2642474cf92a"
awsRegion              = "us-west-2"
environment            = "dev"
prefix                 = "dude-order-status"
```

:::primary: **NOTE**: If you change the environment and prefix, make sure you change the name of the lambda inside the `blueprints/terraform/architect-flows/DudeWheresMyStuffChat_v23-0.yaml` file to the name of the new lambda.
:::

### Run Terraform

Once the environment variables and Terraform configuration from the previous steps have been set, you are now ready to run this blueprint against your organization. Change to the `blueprints/terraform` directory and issue these commands:

1. `terraform plan` - This executes a trial run against your Genesys Cloud organization and shows you a list of all the AWS, and Genesys Cloud resources created. Review this list and make sure you are comfortable with the activity being undertake before continuing to the second step.

2. `terraform apply --auto-approve` - This does the actual object creation and deployment against your AWS and Genesys Cloud accounts. The --auto--approve flag steps the approval step required before creating the objects.

Once the `terraform apply --auto-approve` command has completed, you should see the output of the entire run along with the number of objects successfully created by Terraform. There are two things to keep in mind:

1.  This project assumes you are running using a local Terraform backing state. This means that the `tfstate` files will be created in the same directory where you ran the project. Terraform does not recommend using local Terraform backing state files unless you run from a desktop and are comfortable with the deleted files.

2. As long as your local Terraform backing state projects are kept, you can teardown the blueprint in question by changing to the `blueprint/terraform` directory and issuing a `terraform destroy --auto-approve` command. This destroys all objects currently managed by the local Terraform backing state.

### Test your deployment

Once the chatbot is deployed to your environment, you can test your chatbot by using the Genesys Cloud Web Chat harness to test the newly deployed web chat. The diagram below shows how to use the Web Chat harness.

![Testing your deployed Web Chat](images/testchat.png "Testing your deployed Web Chat")

Go to the [Genesys Cloud Web Chat harness](https://developer.genesys.cloud/developer-tools/#/webchat) in the Genesys Cloud Developer Center. Once there, perform these actions.

1. Select from the Deployment drop-down; the chat deployment you created. In the diagram above, it would be populated with `dev-dude-order-status-chat-widget`. If you do not see that value, the web chat widget did not deploy correctly.
2. Select a queue. This is a Web Chat harness tool requirement. For this example, the 401K queue within my organization was selected.
3. Pre-populate the Chat fields. While you can manually fill in your chat information, you can hit the `Populate Fields` button and the data randomly generates for you.
4. Hit start the chat button. This initiates a chat with your organization.
5. Respond. Once the chat is started, you will be greeted by a chat bot response "`How can I help you with your order today?`". If you respond with the term `order status` and when prompted for your 8-digit order number, you enter `12345678`, you should see the response of `Hi, Thanks for reaching out to us about order #: 12345678. The status of the order is Shipped`. If you receive this response, the chat bot has successfully hit the AWS lambda in question and successfully processed the requests for order status.

If you receive a message from a chatbot that there was a problem with your order, the AWS lambda did not deploy properly, and Genesys Cloud had a problem invoking it.

## Additional resources

* [Genesys Cloud Web Chat](/api/digital/webchat/ "Goes to the web chat documentation") in the Genesys Cloud Developer Center.
* [Genesys Cloud Web Messaging](/api/digital/webmessaging/ "Goes to the web messaging documentation") in the Genesys Cloud Developer Center.
* [Genesys Cloud About the data actions integrations](https://help.mypurecloud.com/?p=209478 "Goes to About the data actions integrations article") in the Genesys Cloud Resource Center
* [Genesys Cloud About the data actions/lambda integrations](https://help.mypurecloud.com/?p=178553 "Goes to About the AWS Lambda data actions integration article") in the Genesys Cloud Resource Center.
* [Terraform Registry Documentation](https://registry.terraform.io/providers/MyPureCloud/genesyscloud/latest/docs "Goes to the Genesys Cloud provider page") in the Terraform documentation.
* [Genesys Cloud DevOps Repository](https://github.com/GenesysCloudDevOps "Goes to the Genesys Cloud DevOps repository page") in GitHub. 
* [deploy-webchat-chatbot-with-lambda-blueprint](https://github.com/GenesysCloudBlueprints/deploy-webchat-chatbot-with-lambda-blueprint "Goes to the deploy-webchat-chatbot-with-lambda-blueprint repository") in GitHub.
* [deploy-webmessaging-chatbot-with-lambda-blueprint](https://github.com/GenesysCloudBlueprints/deploy-webmessaging-chatbot-with-lambda-blueprint "Goes to the deploy-webmessaging-chatbot-with-lambda-blueprint repository") in GitHub.
