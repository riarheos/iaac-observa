https://yandex.cloud/ru/docs/tutorials/infrastructure-management/terraform-quickstart
https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs
https://yandex.cloud/ru/docs/compute/api-ref/
https://yandex.cloud/ru/docs/api-design-guide/concepts/resources-identification

export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)

siege -v -c 4 http://51.250.42.162/proxy

curl -k -u elastic:0Mb94jFi4LwyfGl8m0eI -X POST "https://localhost:9200/_security/user/jacknich?pretty" -H 'Content-Type: application/json' -d'
{
  "password" : "l0ng-r4nd0m-p@ssw0rd",
  "roles" : [ "admin", "other_role1" ],
  "full_name" : "Jack Nicholson",
  "email" : "jacknich@example.com",
  "metadata" : {
    "intelligence" : 7
  }
}