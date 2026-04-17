#!/bin/bash

set -e

echo "Verificando atualizações disponíveis e instalando"  
sudo apt update && sudo apt upgrade -y

echo "Instalando pacotes essenciais de infraestrutura..."
sudo apt install -y build-essential curl wget git unzip htop net-tools ufw gdebi-core
echo "Sistema atualizado."

echo "Configurando regras básicas do firewall para segurança"
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw --force enable

echo "Configurando atualizações automáticas..."
sudo apt install -y unattended-upgrades
sudo systemctl enable --now unattended-upgrades


echo "Instalação RStudio IDE"

sudo apt update -qq

sudo apt install --no-install-recommends software-properties-common dirmngr

wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc

sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt install --no-install-recommends r-base

echo "Instalação concluída com sucesso!"

echo "Instalando MySQL..."
sudo apt install -y mysql-server mysql-client
echo "MySQL instalado com sucesso!"
sudo systemctl enable --now mysql
sudo snap install mysql-workbench-community
echo "MySQL Workbench instalado com sucesso!"

echo "Instalando PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib
echo "PostgreSQL instalado com sucesso!"
sudo systemctl enable --now postgresql
sudo snap install pgadmin4
echo "pgAdmin 4 instalado com sucesso!"

echo "Instalando MongoDB..."
	sudo apt-get update

	sudo apt-get install gnupg curl -y

curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor


echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list

sudo apt update && sudo apt upgrade -y

sudo apt-get install -y mongodb-org

sudo systemctl start mongod

sudo systemctl enable mongod
wget https://downloads.mongodb.com/compass/mongodb-compass_1.49.4_amd64.deb
sudo dpkg -i mongodb-compass_1.49.4_amd64.deb
echo "MongoDB instalado e iniciado com sucesso!"

echo "instalação do virtualbox"
sudo apt install -y virtualbox virtualbox-ext-pack
echo "VirtualBox instalado com sucesso!"
sudo apt update && sudo apt upgrade -y

echo "criação do usuario aluno"
sudo adduser aluno --disabled-password --gecos "Aluno"
sudo passwd aluno
echo "Usuário aluno criado com sucesso!"

sudo add-apt-repository ppa:gns3/ppa -y
sudo apt-get update 
sudo apt-get install gns3-gui gns3-server -y
sudo apt-get install qemu-kvm libvirt-daemon-system virtinst bridge-utils 	docker.io -y
sudo usermod -aG libvirt,kvm,wireshark,docker,ubridge aluno
sudo apt update && sudo apt upgrade -y
sudo apt update && sudo apt upgrade -y
sudo deluser aluno sudo
sudo deluser aluno adm
echo "GNS3 instalado com sucesso!" 
sudo reboot