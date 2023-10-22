#!/bin/bash

sudo docker stop ensine-database-container
sudo docker rm ensine-database-container

echo ""
echo "Container removido"
echo "Iniciando um novo..."
./setup_database.sh

