
/*
Responsible for deploying the lambda, creating its IAM Role and IAM Policy. This module also creates the trusted role and policy that
is used by Genesys Cloud to invoke the lambda in
*/
module "lambda_order_status" {
  source                  = "./modules/lambda_order_status"
  environment             = var.environment
  prefix                  = var.prefix
  organizationId          = var.organizationId
  aws_region              = var.awsRegion
  lambda_zip_file         = data.archive_file.lambda_zip.output_path
  lambda_source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

/*
   This module creates a data integration for the lambda.  The module will create the credentials and in the integration.
*/
module "lambda_data_integration" {
  source                            = "git::https://github.com/GenesysCloudDevOps/integration-lambda-module.git?ref=main"
  environment                       = var.environment
  prefix                            = var.prefix
  data_integration_trusted_role_arn = module.lambda_order_status.data_integration_trusted_role_arn
}

/*
   Setups a data action that will invoke a lambda
*/
module "lambda_data_action" {
  source                 = "git::https://github.com/GenesysCloudDevOps/data-action-lambda-module.git?ref=main"
  environment            = var.environment
  prefix                 = var.prefix
  secure_data_action     = false
  genesys_integration_id = module.lambda_data_integration.genesys_integration_id
  lambda_arn             = module.lambda_order_status.lambda_arn
  data_action_input      = file("${path.module}/contracts/data-action-input.json")
  data_action_output     = file("${path.module}/contracts/data-action-output.json")
}

/*
   Creates the queues used within the flow
*/
module "dude_queues" {
  source                   = "git::https://github.com/GenesysCloudDevOps/genesys-cloud-queues-demo.git?ref=main"
  classifier_queue_names   = ["dude-cancellations", "dude-general-support"]
  classifier_queue_members = []
}


/*   
   Creates the bot flow and inbound message flow
*/
module "my_chat_flow" {
  source                       = "./modules/flows"
  integration_category         = module.lambda_data_action.integration_data_action_category
  integration_data_action_name = module.lambda_data_action.integration_data_action_name
}

/*   
   Configures the widget deployment
   Chat Widget is deprecated
*/
# module "widget_deploy" {
#   source      = "./modules/widget_deployment"
#   environment = var.environment
#   prefix      = var.prefix
#   flowId      = module.my_chat_flow.flow_id
# }

# Create Messenger Configuration
module "web_config" {
  source                            = "./modules/webdeployments_configuration"
  web_deployment_configuration_name = "${var.environment}-${var.prefix}-web-configuration"
}

# Create Messenger Deployment
module "web_deploy" {
  source              = "./modules/webdeployments_deployment"
  web_deployment_name = "${var.environment}-${var.prefix}-web-deployment"
  flow_id             = module.my_chat_flow.message_flow_id
  config_id           = module.web_config.config_id
  config_ver          = module.web_config.config_ver
  depends_on          = [module.my_chat_flow]
}



