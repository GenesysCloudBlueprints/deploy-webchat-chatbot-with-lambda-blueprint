/*
  Creates the messaging deployment and assigns the flow
*/
resource "genesyscloud_webdeployments_deployment" "web_message_deployment" {
  name              = var.web_deployment_name
  flow_id           = var.flow_id
  status            = "Active"
  allow_all_domains = true
  allowed_domains   = []
  configuration {
    id      = var.config_id
    version = var.config_ver
  }
}
