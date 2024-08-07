https://yandex.cloud/ru/docs/tutorials/infrastructure-management/terraform-quickstart
https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs
https://yandex.cloud/ru/docs/compute/api-ref/
https://yandex.cloud/ru/docs/api-design-guide/concepts/resources-identification

export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
