# Домашнее задание к занятию `«Безопасность в облачных провайдерах»` - `Сулименков Алексей`

Используя конфигурации, выполненные в рамках предыдущих домашних заданий, нужно добавить возможность шифрования бакета.

---

## Задание 1. Yandex Cloud

1. С помощью ключа в KMS необходимо зашифровать содержимое бакета:

- создать ключ в KMS;
- с помощью ключа зашифровать содержимое бакета, созданного ранее.

Полезные документы:

- [Настройка HTTPS статичного сайта](https://cloud.yandex.ru/docs/storage/operations/hosting/certificate).
- [Object Storage bucket](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/storage_bucket).
- [KMS key](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kms_symmetric_key).

---

### Ответ

1. Создание ключа в KMS

<details> <summary>Создание ключа в KMS</summary>

```bash
resource "yandex_kms_symmetric_key" "s3_key" {
  name              = "s3-encryption-key"
  description       = "Key for S3 bucket encryption"
  folder_id         = var.folder_id
  rotation_period = "2592000s" # 30 дней
}

```

![KMS](https://github.com/biparasite/homeworks-15.3/blob/main/task_1.2.png "KMS")

</details>

2. Создать букет и зашифровать содержимое бакета

<details> <summary>NLB</summary>

```bash
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

```

![S3_KMS](https://github.com/biparasite/homeworks-15.3/blob/main/task_1.1.png "S3_KMS")

</details>
