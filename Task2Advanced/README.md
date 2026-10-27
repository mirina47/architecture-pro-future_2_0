# Задание 2. Интеграция с CI/CD и удалённым хранением состояния

## Структура проекта
```bash
/Task2Advanced/
  ├── backend.tf # настройка S3-бекенда
  │── main.tf # ресурсы (ВМ через модуль из задания 1)
  │── variables.tf # переменные для провайдера и модуля
  │── terraform.tfvars # файл с переменными
  │── main.tf # ресурсы (ВМ через модуль из задания 1)
  │       ├── main.tf
  │       ├── variables.tf
  │       └── outputs.tf
  └── .github/
      ├── workflows/
          ├── terraform.yml # CI/CD пайплайн
```



## Настройка удаленного состояния (Yandex Object Storage)

### 1. Создание бакета
```bash
yc storage bucket create --name terraform-state-bucket-future
```

### 2. Создание сервисного аккаунта с правами storage.editor
```bash
yc iam service-account create --name tf-state-sa
yc resource-manager folder add-access-binding <folder-id> \
  --role storage.editor \
  --subject serviceAccount:<id-сервис-аккаунта>
```

### 3. Создание статических ключей доступа
```bash
yc iam access-key create --service-account-name tf-state-sa
```
 

 
## Локальная проверка

```bash
export AWS_ACCESS_KEY_ID=<access-key-id>
export AWS_SECRET_ACCESS_KEY=<secret-access-key>
```

```bash
cd Task2Advanced
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

После завершения проверки желательно удалить ресурсы:
```bash
terraform destroy -var-file="terraform.tfvars" 
```