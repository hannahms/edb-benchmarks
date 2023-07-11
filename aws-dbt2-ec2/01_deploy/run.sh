#!/bin/bash -eux

export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_HOST_KEY_CHECKING=false

ansible-playbook \
	-i "${TERRAFORM_PROJECT_PATH}/${TERRAFORM_PROJECT_NAME}/inventory.yml" \
	-e "@../vars.yml" \
	./playbook-deploy.yml
