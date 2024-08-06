resource "yandex_iam_service_account" "paulmd-sa" {
  name        = "paulmd-sa"
  description = "service account to manage VMs"
}

resource "yandex_resourcemanager_folder_iam_binding" "admin" {
  folder_id = "b1guaa1hv85esfel63i6"
  role = "admin"

  members = [
    "serviceAccount:${yandex_iam_service_account.paulmd-sa.id}",
  ]
}