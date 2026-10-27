# Переменные для настройки провайдера
variable "token" {
  description = "Yandex Cloud IAM token"
  type        = string
  sensitive   = true
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Folder ID"
  type        = string
}

# Переменные для настройки виртуальной машины
variable "zone" {}
variable "vm_name" {}
variable "cores" {}
variable "memory" {}
variable "secondary_disk_size" {}
variable "subnet_id" {}
variable "ssh_key" {}
variable "boot_disk_image_id" {}