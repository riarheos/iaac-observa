locals {
  image        = "fd84kp940dsrccckilj6"
  folder       = "b1guaa1hv85esfel63i6"
  zone         = "ru-central1-a"
  minion_count = 2
}

variable "create_salt" {
  description = "Set to 1 to create a salt master"
  type        = number
  default     = 0
}

variable "create_minions" {
  description = "Set to 1 to create salt minions"
  type        = number
  default     = 0
}
