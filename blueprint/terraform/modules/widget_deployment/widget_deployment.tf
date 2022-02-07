/*
  Creates the widget and assigns the flow
*/
resource "genesyscloud_widget_deployment" "mychatwidget" {
  name                    = "${local.resource_name_prefix}-chat-widget"
  description             = "My chat widget"
  flow_id                 = var.flowId
  client_type             = "v2"
  authentication_required = false
  disabled                = false
  allowed_domains         = []
}
