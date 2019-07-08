#!/usr/bin/env bash

echo -e "\nBuilding Cluster";
echo -e "===============================================================\n";

terraform apply;

echo -e "\nWait 5 minutes to let cluster finish installing software\n";
sleep 60;

echo -e "...4 minutes left";
sleep 60;

echo -e "...3 minutes left";
sleep 60;

echo -e "...2 minutes left";
sleep 60;

echo -e "...1 minute left";
sleep 60;

echo -e "\nConfiguring cluster";
rm -f secrets/*;

echo -e "\n=====[ Identifying hosts ]===================================\n";
./scripts/tfinventory.py > inventory/hosts;

echo -e "\n=====[ Configuring hosts ]===================================\n";
ansible-playbook -i inventory hosts.yaml;

echo -e "\n=====[ Configuring Consul ]===================================\n";
ansible-playbook -i inventory consul.yaml;

echo -e "\n=====[ Configuring Vault ]===================================\n";
ansible-playbook -i inventory vault.yaml;

echo -e "\n=====[ Configuring Nomad ]===================================\n";
ansible-playbook -i inventory nomad.yaml;

echo -e "\n=====[ Configuring Redis ]===================================\n";
ansible-playbook -i inventory redis.yaml;

echo -e "\n=====[ Configuring Mongo ]===================================\n";
ansible-playbook -i inventory mongo.yaml;

