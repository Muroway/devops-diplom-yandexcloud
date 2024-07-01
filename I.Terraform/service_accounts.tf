#Сервисный аккаунт для S3 bucket terraform
// Create SA
resource "yandex_iam_service_account" "bucket-sa" {
    folder_id = var.folder_id
    name = "bucketbot"
}

// Grant pemissions
resource "yandex_resourcemanager_folder_iam_member" "bucket-sa-editor" {
    folder_id = var.folder_id
    role = "storage.editor"
    member = "serviceAccount:${yandex_iam_service_account.bucket-sa.id}"
}


#Сервисный аккаунт для Yandex Compute Registry
// Create SA
resource "yandex_iam_service_account" "docker-sa" {
    folder_id = var.folder_id
    name = "dockerbot"
}

// Grant pemissions
resource "yandex_resourcemanager_folder_iam_member" "docker-sa-editor" {
    folder_id = var.folder_id
    role = "container-registry.editor"
    member = "serviceAccount:${yandex_iam_service_account.docker-sa.id}"
}

# //Create static access keys
# resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
# service_account_id = yandex_iam_service_account.sa.id
# description = "static access key for object storage"
# }

# // Use keys to create bucket
# resource "yandex_storage_bucket" "drutskoi-bucket" {
#     access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
#     secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
#     bucket = "drutskoi-bucket"
# }
# */