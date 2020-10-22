[![Build Status](https://travis-ci.com/Otus-DevOps-2020-08/ProfMalina_infra.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2020-08/ProfMalina_infra)


# ProfMalina_infra
ProfMalina Infra repository

# Bastion
Для подключения из консоли при помощи команды вида ssh someinternalhost был создан файл config в дирректории ~/.ssh со следующим содержанием
Host bastion
    HostName 84.201.153.63
    User appuser
	ForwardAgent yes
	IdentityFile .\.ssh\appuser
Host someinternalhost
    HostName 10.129.0.34
	User appuser
	ProxyJump bastion

bastion_IP = 84.201.153.63

someinternalhost_IP = 10.129.0.34

# cloud-testapp

testapp_IP = 84.201.157.109

testapp_port = 9292

Команда создания инстанса
yc compute instance create --name reddit-app --hostname reddit-app --memory=4 --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 --metadata serial-port-enable=1 --metadata-from-file user-data=startup.yml

# packer-base

Созданы образы reddit-base и reddit full, добавлен скрипт автоматизации создания ВМ

packer build -var-file=variables.json ./ubuntu16.json
packer build -var-file=variables.json ./immutable.json

# terraform-1

Добавил создание инстансов через terraform
Добавил создание балансера через terraform и проверил

# terraform-2

Разбил на модули, создал новые образы, создал бакет и поместил на него tfstate, собрал работающее приложение из модулей

# ansible-1

При выполнении ansible-playbook видно были произведены изменения или нет если в них не было необходимости

Например changed=1 или changed=0

Для генерации inventory.json использовал встроееные в terraform инструменты
Добавил в output `resource "local_file" "AnsibleInventory"`, и файл болванку inventory.tmpl, после отработки в папку ansible кладется файл inventory.json, команда `ansible all -m ping` отрабатывает

После добавления, если инстансы уже созданы, то надо проверить командой terraform plan, что новый ресурс будет добавлен, а затем использовать команду `terraform apply -auto-approve`

Если надо пересоздать данный файл, то используются следующие команды
`terraform taint local_file.AnsibleInventory`
`terraform apply -auto-approve`

# ansible-2

Создал плейбуки разных форматов

Добавил в генерацию inventory.json ip_db и переменную в плейбуки

Собрал новые образы с использованием Packer+Ansible

Поднял инстансы на новых образах, задеплоил приложение с помощью плэйбука site.yml

# ansible-3

Плейбуки разделены на роли

Добавлены два окружения

Использован Ansible Vault для хранения секретов

Добавлена генерация inventory для обоих окружений ansible

Добавлены проверки для TravisCI

Добавил бэйдж в README.MD

# ansible-4

Доработал роли, проверил работу в vagrant и в terraform

Активация virtualenv `source venv/bin/activate`
