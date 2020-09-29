terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-bucket-malinovskiy"
    region     = "ru-central1"
    key        = "tf_files/prod.tfstate"
    access_key = "access_key"
    secret_key = "secret_key"


    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
