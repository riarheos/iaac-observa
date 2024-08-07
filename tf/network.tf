resource "yandex_vpc_network" "net" {
  name = "kit-net"
}

resource "yandex_vpc_subnet" "subnet-a" {
  name           = "kit-subnet-a"
  zone           = local.zone
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["10.0.0.0/24"]
}