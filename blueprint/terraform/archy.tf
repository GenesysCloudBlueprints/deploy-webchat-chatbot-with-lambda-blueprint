resource "null_resource" "deploy_archy_flow_bot" {
  depends_on = [
    module.lambda_data_integration,
    module.lambda_data_action
  ]

  provisioner "local-exec" {
    command = "  archy publish --forceUnlock --file architect-flows/DudesWheresMyStuffBot_v16-0.yaml --clientId $GENESYSCLOUD_OAUTHCLIENT_ID --clientSecret $GENESYSCLOUD_OAUTHCLIENT_SECRET --location $GENESYSCLOUD_ARCHY_REGION  --overwriteResultsFile --resultsFile results.json "
  }
}

resource "null_resource" "deploy_archy_flow_chat" {
  depends_on = [
    module.lambda_data_integration,
    module.lambda_data_action,
    null_resource.deploy_archy_flow_bot,
    module.dude_queues
  ]

  provisioner "local-exec" {
    command = "  archy publish --forceUnlock --file architect-flows/DudeWheresMyStuffChat_v23-0.yaml --clientId $GENESYSCLOUD_OAUTHCLIENT_ID --clientSecret $GENESYSCLOUD_OAUTHCLIENT_SECRET --location $GENESYSCLOUD_ARCHY_REGION  --overwriteResultsFile --resultsFile results.json "
  }
}


