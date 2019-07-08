#!/usr/bin/env bash

# Digital Oceal Monitoring
curl -sSL https://agent.digitalocean.com/install.sh | sh

# Update and upgrade packages
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' upgrade
apt-get install -y unzip wget python-minimal python-apt python-pip aptitude apt-transport-https jq

# New packages
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list

apt-get update
apt-get install -y redis-server mongodb-org filebeat
apt autoremove -y

# Specialist packages
wget https://releases.hashicorp.com/consul/1.5.2/consul_1.5.2_linux_amd64.zip -O /tmp/consul.zip -o /dev/null
wget https://releases.hashicorp.com/nomad/0.9.3/nomad_0.9.3_linux_amd64.zip -O /tmp/nomad.zip -o /dev/null
wget https://releases.hashicorp.com/vault/1.1.3/vault_1.1.3_linux_amd64.zip -O /tmp/vault.zip -o /dev/null
wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz -O /tmp/prometheus.tar.gz -o /dev/null
unzip /tmp/consul.zip -d /usr/local/bin
unzip /tmp/nomad.zip -d /usr/local/bin
unzip /tmp/vault.zip -d /usr/local/bin
tar zxf /tmp/prometheus.tar.gz -C /tmp
install /tmp/node_exporter-0.18.1.linux-amd64/node_exporter /usr/local/bin
rm -rf /tmp/consul*
rm -rf /tmp/vault*
rm -rf /tmp/nomad*

# Finalise
service mongod restart
echo 'manage_etc_hosts: False' | tee --append /etc/cloud/cloud.cfg
