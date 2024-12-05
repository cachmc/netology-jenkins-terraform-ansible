terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      configuration_aliases = [ yandex ]      
    }
  }
  required_version = "~>1.8.4"
}
