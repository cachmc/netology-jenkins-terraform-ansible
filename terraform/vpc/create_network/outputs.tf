output "network_id" {
  value = yandex_vpc_network.create_network.id
  description = "ID of the created network"
}

output "subnets" {
  value = [ for subnet in yandex_vpc_subnet.create_subnet : {name: subnet.name, id: subnet.id}  ]
  description = "Information about the created subnets"
}
