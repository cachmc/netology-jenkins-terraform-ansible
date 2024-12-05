terraform {
  required_version = "~>1.8.4"

  backend "s3" {
    shared_credentials_files = ["~/.aws/credentials"]
#    profile                  = "default"
    region                   = "ru-central1"

    bucket = "svm-tfstate"
    key    = "jenkins-04/vms/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true

    endpoints = {
      dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gckqal9th70votrnub/etnqbr8fk7pv2uo65cos"
      s3       = "https://storage.yandexcloud.net"
    }

    dynamodb_table = "tfstate_lock_develope"
  }

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.133.0"
    }

    template = {
      source  = "hashicorp/template"
      version = "> 2.0"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}
