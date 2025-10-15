variable "cloud_id" {
    type=string
    default="b1gd2j85a1qkvque4sv7"
}
variable "folder_id" {
    type=string
    default="b1g58l0sc9sfdif3gs79"
}

#считываем данные об образ
data "yandex_compute_image" "lamp-instance" {
  family = "lamp"
}

variable "vm_test_platform" {
  type        = string
  default     = "standard-v1"
  description = "VM platform"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "ru-central1-a"
}
