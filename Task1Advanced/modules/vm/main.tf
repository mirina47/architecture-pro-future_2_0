terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_compute_disk" "secondary" {
  count = var.secondary_disk_size > 0 ? 1 : 0
  name  = "${var.vm_name}-data"
  zone  = var.zone
  size  = var.secondary_disk_size
}

resource "yandex_compute_instance" "vm" {
  name = var.vm_name
  zone = var.zone

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = var.boot_disk_image_id
    }
  }

  dynamic "secondary_disk" {
    for_each = var.secondary_disk_size > 0 ? [1] : []
    content {
      disk_id = yandex_compute_disk.secondary[0].id
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = var.ssh_key
  }
}