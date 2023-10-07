.PHONY: generate_hosts init-server

generate_hosts:
	./scripts/generate_hosts.sh

init-server: generate_hosts
	ansible-playbook -i hosts.yaml init_server.yaml
