variable "name" {
  default = "efs"
}

variable "enabled" {
  default = true
}

variable "backup" {
  default = true
}

variable "schedule" {
  default = "cron(0 5 ? * * *)"
}

variable "delete_after" {
  default = 30
}

variable "cold_storage_after" {
  default = null
}

variable "throughput_mode" {
  default = null
}

variable "provisioned_throughput_in_mibps" {
  default = null
}
