#!/bin/bash

set -e

echo "Script de instalação para a EC2 database"
echo ""
sleep 2

echo "Configuração EC2"
sleep 1
echo ""
sudo apt update

echo ""
echo "Verificando instalação do docker..."
sleep 1
echo ""
if !command -v docker &> /dev/null; then
	echo "Docker não está instalado. Instalando docker.io..."
	sudo apt install -y docker.io
	sudo systemctl start docker
	sudo systemctl enable docker
else
	echo "Docker já instalado."
fi

#echo "Clonando repositório do github..."
#sleep 1
#read -p "Username github: " username
#read -s -p "Token github: " token
#
 #if [ ! -d "Database" ]; then
#	git clone https://$username:$token@github.com/ensine-me/Database.git
#else
#	echo "Repositório já clonado."
#fi
#sleep 1
#
#unset username
#unset token

echo "Entrando no repositório e iniciando configuração do container..."
sleep 1
if [ ! -f "Dockerfile" ]; then
	echo "Dockerfile não encontrado."
	exit 1
fi

echo ""
echo "construindo imagem docker..."
sudo docker build -t ensine-database-image .
echo ""
echo "Iniciando container docker..."
sleep 1
sudo docker run --name ensine-database-container -p 5432:5432 -d ensine-database-image

echo "Containers ativos:"
sudo docker ps -a
echo ""

#!/bin/bash

# Configuração
HOST="localhost"
PORT="5432"
DB_USER="ensine_admin"

# Aguarda o banco de dados estar pronto
sudo docker exec -it ensine-database-container /bin/bash -c "
until pg_isready -h '$HOST' -p '$PORT' -U '$DB_USER'
do
  echo 'Aguardando o banco de dados estar pronto...'
  sleep 1
done
"
sleep 1
# Configurar coluna 'id' para autoincremento
echo "1"
sudo docker exec -it ensine-database-container psql -U 'ensine_admin' -d ensineme -c "ALTER TABLE usuario ALTER COLUMN id_usuario DROP DEFAULT;"
echo "2"
sudo docker exec -it ensine-database-container psql -U 'ensine_admin' -d ensineme -c "ALTER TABLE usuario ALTER COLUMN id_usuario ADD GENERATED BY DEFAULT AS IDENTITY;"

echo ""
sleep 1
echo "Script finalizado!"
