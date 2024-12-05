data "yandex_compute_image" "image_ubuntu" {
  family = "ubuntu-${var.ubuntu_version}-lts"
}

data "yandex_compute_image" "image_centos" {
  family = "centos-${var.centos_version}-oslogin"
}


resource "yandex_compute_instance" "create_vms" {
  count    = var.count_vms

  name        = "${var.configuration_vm.name}-${count.index+1}"
  hostname    = "${var.configuration_vm.name}-${count.index+1}"
  platform_id = var.configuration_vm.platform_id
#  zone        = element(var.subnet_zones, count.index)
  zone        = (var.configuration_vm.platform_id == "standard-v1" && element(var.subnet_zones, count.index) == "ru-central1-d") ? element(var.subnet_zones, count.index+1) : element(var.subnet_zones, count.index)
  resources {
    cores         = var.configuration_vm.cores
    memory        = var.configuration_vm.memory
    core_fraction = var.configuration_vm.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image_centos.image_id
      size     = var.configuration_vm.disk_volume
    }
  }
  scheduling_policy {
    preemptible = var.configuration_vm.preemptible
  }
  network_interface {
#    subnet_id          = element(data.terraform_remote_state.network.outputs.vpc_dev.subnets, count.index).id
    subnet_id          = (var.configuration_vm.platform_id == "standard-v1" && length(regexall("ru-central1-d", element(data.terraform_remote_state.network.outputs.vpc_dev.subnets, count.index).name)) > 0) ? element(data.terraform_remote_state.network.outputs.vpc_dev.subnets, count.index+1).id : element(data.terraform_remote_state.network.outputs.vpc_dev.subnets, count.index).id
    nat                = var.configuration_vm.nat
  }
  labels = {
    owner   = "v.shishkov"
    project = "java-machine"
  }
  metadata = {
    serial-port-enable = var.configuration_vm.serial_port_enable
    user-data          = data.template_file.cloudinit.rendered
  }
}


data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init.yaml")

  vars = {
    ssh_user = var.ssh_user
    ssh_key  = var.ssh_key      
  }
}
