#!/bin/bash -eux

export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_HOST_KEY_CHECKING=false

ansible-playbook \
	-i "${TERRAFORM_PROJECT_PATH}/terraform/inventory.yml" \
	-e "@../vars.yml" \
	./playbook-deploy.yml
