resource "yandex_iam_service_account" "paulmd-sa" {
  name        = "paulmd-sa"
  description = "service account to manage VMs"
}