output "vm_id" {
  value = yandex_compute_instance.vm.id
}

output "vm_name" {
  value = yandex_compute_instance.vm.name
}

output "internal_ip" {
  value = yandex_compute_instance.vm.network_interface[0].ip_address
}

output "external_ip" {
  value = yandex_compute_instance.vm.network_interface[0].nat_ip_address
}

output "secondary_disk_id" {
  value = var.secondary_disk_size > 0 ? yandex_compute_disk.secondary[0].id : null
}