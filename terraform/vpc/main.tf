module "vpc_dev" {
  source       = "./create_network"
  env_name     = "${var.prefix_name}"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.3.0/24" },
  ]

  providers = {
    yandex = yandex
  }
}
