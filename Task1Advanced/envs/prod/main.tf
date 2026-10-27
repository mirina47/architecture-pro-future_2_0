terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.206.0"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

module "vm" {
  source = "../../modules/vm"

  vm_name             = var.vm_name
  cores               = var.cores
  memory              = var.memory
  secondary_disk_size = var.secondary_disk_size
  subnet_id           = var.subnet_id
  ssh_key             = var.ssh_key
  boot_disk_image_id  = var.boot_disk_image_id
  zone                = var.zone
}