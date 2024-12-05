output "dynamic_vms" {
  value = [ for vm in yandex_compute_instance.create_vms: {
    name        = vm.name
    id          = vm.id
    external_ip = vm.network_interface.0.nat_ip_address
    fqdn        = vm.fqdn 
  }]

  description = "Information about all dynamic servers"
}
