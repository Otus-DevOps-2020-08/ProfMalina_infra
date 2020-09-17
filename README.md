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
teatapp_port = 9292

Команда создания инстанса
yc compute instance create --name reddit-app --hostname reddit-app --memory=4 --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 --metadata serial-port-enable=1 --metadata-from-file user-data=startup.yml
