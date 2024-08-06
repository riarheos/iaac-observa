resource "yandex_compute_instance_group" "minions-group" {
  depends_on = [yandex_compute_instance.master-vm]

  name = "minions-group"
  service_account_id = yandex_iam_service_account.paulmd-sa.id

  allocation_policy {
    zones = [var.zone]
  }

  deploy_policy {
    max_expansion   = 1
    max_unavailable = 1
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  instance_template {
    name = "minion-{instance.short_id}"

    resources {
      cores  = 2
      memory = 1
      core_fraction = 5
    }

    scheduling_policy {
      preemptible = true
    }

    boot_disk {
      initialize_params {
        size = 20
        image_id = local.image
      }
    }

    network_interface {
      subnet_ids = [yandex_vpc_subnet.subnet-a.id]
      nat = true
    }

    metadata = {
      user-data = file("cloud-init.yaml")
    }
  }
}