locals {
  image = "fd84kp940dsrccckilj6"
}

variable "zone" {
  description = "The zone to deploy into"
  type        = string
  default     = "ru-central1-a"
}