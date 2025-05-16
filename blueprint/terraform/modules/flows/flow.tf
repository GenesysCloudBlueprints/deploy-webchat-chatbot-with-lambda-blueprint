resource "genesyscloud_flow" "deploy_archy_flow_bot" {
  filepath          = "${path.module}/DudesWheresMyStuffBot.yaml"
  file_content_hash = filesha256("${path.module}/DudesWheresMyStuffBot.yaml")
  substitutions = {
    flow_name        = "DudesWheresMyStuffBot"
    default_language = "en-us"
  }
}

# Chat Flow is deprecated
# resource "genesyscloud_flow" "deploy_archy_flow_chat" {
#   filepath          = "${path.module}/DudeWheresMyStuffChat.yaml"
#   file_content_hash = filesha256("${path.module}/DudeWheresMyStuffChat.yaml")
#   substitutions = {
#     flow_name                    = "DudeWheresMyStuffChat"
#     default_language             = "en-us"
#     integration_category         = var.integration_category
#     integration_data_action_name = var.integration_data_action_name
#   }
# }

resource "genesyscloud_flow" "deploy_message_flow" {
  filepath          = "${path.module}/DudeWheresMyStuffMessage.yaml"
  file_content_hash = filesha256("${path.module}/DudeWheresMyStuffMessage.yaml")
  substitutions = {
    flow_name                    = "DudeWheresMyStuffMessage"
    default_language             = "en-us"
    integration_category         = var.integration_category
    integration_data_action_name = var.integration_data_action_name
  }
}
