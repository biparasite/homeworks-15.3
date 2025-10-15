resource "yandex_storage_bucket" "iam-bucket" {
  bucket    = "iam-bucket-asv-sula"
  max_size              = 10485760
  default_storage_class = "standard"
  force_destroy = true
  server_side_encryption_configuration {
    rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = yandex_kms_symmetric_key.s3_key.id
      sse_algorithm     = "aws:kms"
    }
  }
  }
  anonymous_access_flags {
    read        = true
    list        = true
    config_read = false
  }
}

resource "yandex_storage_object" "iam-bucket-asv-sula" {
  bucket = "iam-bucket-asv-sula"
  # acl = "public_read"
  content_type = "image/jpeg"
  key    = "task_1.2.png"
  source = "/Users/biparasite/Documents/Netology/Git/homeworks-15.1/task_1.2.png"
  depends_on = [yandex_storage_bucket.iam-bucket]

}

