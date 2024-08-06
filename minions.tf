# resource "yandex_compute_instance_group" "minions-group" {
#   name = "minions-group"
#   service_account_id = "ajeoi0k6f2skjqem2mjg"
#
#   allocation_policy {
#     zones = [var.zone]
#   }
#
#   deploy_policy {
#     max_expansion   = 1
#     max_unavailable = 1
#   }
#
#   scale_policy {
#     fixed_scale {
#       size = 2
#     }
#   }
#
#   instance_template {
#     name = "minion-{instance.short_id}"
#
#     resources {
#       cores  = 2
#       memory = 1
#       core_fraction = 5
#     }
#
#     scheduling_policy {
#       preemptible = true
#     }
#
#     boot_disk {
#       initialize_params {
#         size = 20
#         image_id = local.image
#       }
#     }
#
#     network_interface {
#       subnet_ids = [yandex_vpc_subnet.subnet-a.id]
#       nat = true
#     }
#
#     metadata = {
#       user-data = file("cloud-init.yaml")
#     }
#   }
# }