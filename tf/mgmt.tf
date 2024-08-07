resource "yandex_compute_disk" "mgmt-disk" {
  name     = "mgmt-disk"
  type     = "network-hdd"
  zone     = local.zone
  size     = "20"
  image_id = local.image

  count = var.create_mgmt
}

resource "yandex_compute_instance" "mgmt-vm" {
  depends_on = [yandex_compute_disk.mgmt-disk[0]]

  name     = "mgmt-vm"
  hostname = "mgmt"

  resources {
    cores  = 2
    memory = 2
    #     core_fraction = 5
  }

  boot_disk {
    disk_id = yandex_compute_disk.mgmt-disk[count.index].id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat       = true
  }

  labels = {
    node_type = "mgmt"
  }

  metadata = {
    user-data = file("../salt-obs/cloud-init-mgmt.yaml")
  }

  allow_stopping_for_update = true

  count = var.create_mgmt
}
