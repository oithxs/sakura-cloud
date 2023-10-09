#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

cd ../../terraform

ip_addresses=($(terraform output -json | jq -r '.ip_address.value[]'))
server_names=($(terraform output -json | jq -r '.server_name.value[]'))

cd $SCRIPT_DIR/..

cat << EOF > hosts.yaml
all:
  children:
    servers:
      hosts:
EOF

for i in "${!ip_addresses[@]}"; do
  echo "        ${server_names[i]}:" >> hosts.yaml
  echo "          ansible_host: ${ip_addresses[i]}" >> hosts.yaml
  echo "          ansible_become_password: $TF_VAR_server_password" >> hosts.yaml
  echo "          ansible_ssh_private_key_file: ~/.ssh/id_ed25519" >> hosts.yaml
done
