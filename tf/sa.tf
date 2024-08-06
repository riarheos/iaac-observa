resource "yandex_iam_service_account" "paulmd-sa" {
  name        = "paulmd-sa"
  description = "service account to manage VMs"
}

resource "yandex_resourcemanager_folder_iam_binding" "paulmd-sa-admin" {
  folder_id = local.folder
  role      = "admin"

  members = [
    "serviceAccount:${yandex_iam_service_account.paulmd-sa.id}",
  ]
}