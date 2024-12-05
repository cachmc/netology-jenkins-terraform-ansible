variable "ubuntu_version" {
  type        = string
  default     = "2004"
  description = "Version OS Ubuntu"
}

variable "centos_version" {
  type        = string
  default     = "stream-9"
  description = "Version OS Centos"
}

variable "count_vms" {
  type        = number
#  default     = 1
  description = "Count VMs"
}

variable "configuration_vm" {
  type = object({
    name               = string
    platform_id        = string
    cores              = number
    memory             = number
    core_fraction      = number
    disk_volume        = number
    preemptible        = bool
    nat                = bool
    serial_port_enable = number
  })
  default = {
    name               = "java-test"
    platform_id        = "standard-v1"
    cores              = 2
    memory             = 1
    core_fraction      = 5
    disk_volume        = 10
    preemptible        = true
    nat                = true
    serial_port_enable = 1
  }
  description = "Configuration VM"
}
