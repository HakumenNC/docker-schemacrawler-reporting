#!/bin/sh

sudo yum install -y vim

# Installation de Docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

# Installation de ELK
cd /vagrant
docker-compose --project-name schemacrawler-elk -f elk.yml up -d
sudo chown -R vagrant:vagrant elasticsearch
sudo chown -R vagrant:vagrant exportcsv

# Installation de la base de test Postgresql
docker-compose -f sampledb/postgres.yml up -d

# Installation de Portainer
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
