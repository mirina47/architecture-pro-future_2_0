terraform {
  backend "s3" {
    bucket                      = "terraform-state-bucket-future"
    key                         = "Task2Advanced/terraform.tfstate"
    endpoints                   = {
      s3 = "https://storage.yandexcloud.net"
    }
    region                      = "ru-central1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
  }
}