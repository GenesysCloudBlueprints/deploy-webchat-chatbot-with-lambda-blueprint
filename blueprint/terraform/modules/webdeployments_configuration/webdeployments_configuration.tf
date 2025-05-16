// Creates the messaging configuration
resource "genesyscloud_webdeployments_configuration" "web_message_configuration" {
  name             = var.web_deployment_configuration_name
  languages        = ["ar", "cs", "da", "de", "en-us", "es", "fi", "fr", "it", "ja", "ko", "nl", "no", "pl", "pt-br", "ru", "sv", "th", "tr", "zh-cn", "zh-tw"]
  default_language = "en-us"
  messenger {
    enabled = true
    launcher_button {
      visibility = "On"
    }
    styles {
      primary_color = "#FF4F1F"
    }
    file_upload {
      mode {
        file_types       = ["image/png"]
        max_file_size_kb = 256
      }
      mode {
        file_types       = ["image/jpeg"]
        max_file_size_kb = 128
      }
    }
  }
  journey_events {
    enabled = false
  }
}
