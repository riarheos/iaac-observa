resource "yandex_compute_disk" "master-disk" {
  name     = "master-disk"
  type     = "network-hdd"
  zone     = var.zone
  size     = "20"
  image_id = local.image
}

resource "yandex_compute_instance" "master-vm" {
  name = "master-vm"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    disk_id = yandex_compute_disk.master-disk.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat       = true
  }

  metadata = {
    user-data = file("cloud-init.yaml")
  }
}
