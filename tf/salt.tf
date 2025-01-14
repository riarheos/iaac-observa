resource "yandex_compute_disk" "salt-disk" {
  name     = "salt-disk"
  type     = "network-hdd"
  zone     = local.zone
  size     = "20"
  image_id = local.image

  count = var.create_salt
}

resource "yandex_compute_instance" "salt-vm" {
  depends_on = [yandex_compute_disk.salt-disk[0]]

  name               = "salt-vm"
  hostname           = "salt"
  service_account_id = yandex_iam_service_account.paulmd-sa.id

  resources {
    cores  = 2
    memory = 2
    #     core_fraction = 5
  }

  boot_disk {
    disk_id = yandex_compute_disk.salt-disk[count.index].id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat       = true
  }

  labels = {
    node_type = "salt-master"
  }

  metadata = {
    user-data = file("../salt/cloud-init-master.yaml")
  }

  allow_stopping_for_update = true

  count = var.create_salt
}

resource "yandex_compute_instance_group" "minions-group" {
  depends_on = [
    yandex_compute_instance.salt-vm,
    yandex_resourcemanager_folder_iam_binding.paulmd-sa-admin
  ]

  name               = "minions-group"
  service_account_id = yandex_iam_service_account.paulmd-sa.id

  allocation_policy {
    zones = [local.zone]
  }

  deploy_policy {
    max_expansion   = local.minion_count
    max_unavailable = 1
  }

  scale_policy {
    fixed_scale {
      size = local.minion_count
    }
  }

  load_balancer {
    target_group_name = "minions-target-group"
  }

  instance_template {
    name = "minion-{instance.short_id}"

    resources {
      cores  = 2
      memory = 2
      #       core_fraction = 20
    }

    scheduling_policy {
      preemptible = true
    }

    boot_disk {
      initialize_params {
        size     = 20
        image_id = local.image
      }
    }

    network_interface {
      subnet_ids = [yandex_vpc_subnet.subnet-a.id]
      nat        = true
    }

    labels = {
      node_type = "salt-minion"
    }

    metadata = {
      user-data = file("../salt/cloud-init-minion.yaml")
    }
  }

  count = var.create_minions
}

resource "yandex_lb_network_load_balancer" "minions-lb" {
  name = "minions-lb"

  listener {
    name        = "minions-listener"
    port        = 80
    target_port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.minions-group[0].load_balancer[0].target_group_id

    healthcheck {
      name = "tcp"
      tcp_options {
        port = 80
      }
    }
  }

  count = var.create_minions
}