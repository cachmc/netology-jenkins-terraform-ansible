resource "local_file" "inventory_templatefile" {
  content = templatefile("${path.module}/inventory.tftpl", {
    vms = yandex_compute_instance.create_vms
  })

  filename = "${abspath(path.module)}/../../ansible/inventory/test.yml"
}
