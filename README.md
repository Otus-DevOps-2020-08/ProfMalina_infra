# ProfMalina_infra
ProfMalina Infra repository

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
