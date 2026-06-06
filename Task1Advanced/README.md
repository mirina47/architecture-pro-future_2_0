# Задание 1. Модульная инфраструктура для нескольких сред

## Terraform модуль vm_module для Yandex Cloud

### Описание
Переиспользуемый модуль для создания виртуальной машины в Yandex Cloud с возможностью подключения дополнительного диска. Параметры (CPU, RAM, дополнительный диск, сеть, SSH) задаются через переменные, что позволяет использовать один и тот же модуль для разных окружений (dev, stage, prod).

#### Структура проекта
```
/Task1Advanced/
  ├── modules/
  │   └── vm/
  │       ├── main.tf
  │       ├── variables.tf
  │       └── outputs.tf
  └── envs/
      ├── dev/
      ├── stage/
      └── prod/
```


В каждой папке окружения лежат:
- `main.tf` — вызов модуля и настройка провайдера;
- `variables.tf` — объявление переменных;
- `terraform.tfvars` — конкретные значения для окружения (разные для dev/stage/prod).



### Параметры модуля 

#### Входные переменные
| Имя | Тип | Обязательный | Описание |
|-----|-----|--------------|----------|
| `vm_name` | string | да | Имя виртуальной машины |
| `cores` | number | да | Количество vCPU |
| `memory` | number | да | Объём RAM в ГБ |
| `secondary_disk_size` | number | да | Размер дополнительного диска в ГБ (0 — без диска) |
| `subnet_id` | string | да | ID подсети в Yandex Cloud |
| `ssh_key` | string | да | Публичный SSH-ключ в формате `"user:ssh-rsa ..."` |
| `boot_disk_image_id` | string | да | ID образа ОС (например, Ubuntu 22.04) |
| `zone` | string | нет | Зона доступности (по умолч. `ru-central1-a`) |

#### Выходные значения модуля
| Имя | Описание |
|-----|----------|
| `vm_id` | ID созданной ВМ |
| `vm_name` | Имя ВМ |
| `internal_ip` | Внутренний IP-адрес |
| `external_ip` | Внешний IP-адрес (если включён NAT) |
| `secondary_disk_id` | ID дополнительного диска (или `null`, если диск не создавался) |



### Настройка аутентификации в Yandex Cloud
Для работы Terraform требуется IAM-токен, `cloud_id` и `folder_id`. В текущей реализации эти параметры передаются через переменные в `terraform.tfvars`:

```hcl
token     = "ваш_IAM_токен"
cloud_id  = "ваш_cloud_id"
folder_id = "ваш_folder_id"
zone      = "ru-central1-a"
```

#### Как получить IAM-токен:
```bash
yc iam create-token
```
Токен действует ~12 часов. При его истечении нужно обновить значение в terraform.tfvars.

#### Как получить `cloud_id` и `folder_id`:
```bash
yc config get cloud-id
yc config get folder-id
```



### Запуск для окружения
```bash
cd Task1Advanced/envs/dev   # или stage/prod
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

После завершения работы желательно удалить ресурсы:
```bash
terraform destroy -var-file="terraform.tfvars" 
```