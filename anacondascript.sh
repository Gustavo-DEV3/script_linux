#!/bin/bash
set -e
echo "Instalando Anaconda..."
wget https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh -O ~/anaconda.sh
bash ~/anaconda.sh -b -p ~/anaconda3
rm ~/anaconda.sh
~/anaconda3/bin/conda init bash
source ~/.bashrc
conda install -y -c conda-forge r-base r-essentials
conda install -y -c conda-forge orange3
echo "Anaconda instalado com sucesso!"