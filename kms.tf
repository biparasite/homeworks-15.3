resource "yandex_kms_symmetric_key" "s3_key" {
  name              = "s3-encryption-key"
  description       = "Key for S3 bucket encryption"
  folder_id         = var.folder_id
  rotation_period = "2592000s" # 30 дней
#   destructive_delete_with_audit_checks = false
}
