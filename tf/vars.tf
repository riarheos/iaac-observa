locals {
  image  = "fd84kp940dsrccckilj6"
  folder = "b1guaa1hv85esfel63i6"
}

variable "zone" {
  description = "The zone to deploy into"
  type        = string
  default     = "ru-central1-a"
}