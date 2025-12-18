resource "genesyscloud_flow" "deploy_archy_flow_bot" {
  filepath = "${path.module}/DudesWheresMyStuffBot.yaml"
  substitutions = {
    flow_name             = "DudesWheresMyStuffBot"
    default_language      = "en-us"
  }
}

resource "genesyscloud_flow" "deploy_archy_flow_chat" {
  filepath = "${path.module}/DudeWheresMyStuffChat.yaml"
  file_content_hash = filesha256("${path.module}/DudeWheresMyStuffChat.yaml") 
  substitutions = {
    flow_name           = "DudeWheresMyStuffChat"
    default_language    = "en-us"
    integration_category = var.integration_category
    integration_data_action_name = var.integration_data_action_name
  }
}