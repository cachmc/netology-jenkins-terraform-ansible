resource "yandex_vpc_network" "create_network" {
  name = var.env_name
}

resource "yandex_vpc_subnet" "create_subnet" {
  for_each = { for i, subnet in var.subnets: i => subnet }

  name           = "${var.env_name}-${each.value.zone}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.create_network.id
  v4_cidr_blocks = [each.value.cidr]
}
