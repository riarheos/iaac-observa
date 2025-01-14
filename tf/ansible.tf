resource "yandex_compute_disk" "ansible-disk" {
  name     = "ansible-disk"
  type     = "network-hdd"
  zone     = local.zone
  size     = "20"
  image_id = local.image
}

resource "yandex_compute_instance" "ansible-vm" {
  name     = "ansible-vm"
  hostname = "ansible"

  resources {
    cores  = 2
    memory = 2
    #     core_fraction = 5
  }

  boot_disk {
    disk_id = yandex_compute_disk.ansible-disk.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat       = true
  }

  labels = {
    node_type = "ansible"
  }

  metadata = {
    user-data = file("../ansible/cloud-init.yaml")
  }
}
