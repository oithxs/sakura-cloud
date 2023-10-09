.PHONY: generate-hosts get-ssh-public-key init-server

generate-hosts:
	./scripts/generate_hosts.sh

get-ssh-public-key:
	./scripts/get_ssh_public_key.sh

init-server: generate-hosts get-ssh-public-key
	ansible-playbook -i hosts.yaml init_server.yaml
