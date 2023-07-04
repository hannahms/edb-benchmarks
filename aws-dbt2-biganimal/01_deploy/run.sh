#!/bin/bash -eux

export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_HOST_KEY_CHECKING=false
export TERRAFORM_PROJECT_PATH="${RESULTS_DIRECTORY}/${TERRAFORM_PROJECT_NAME}"

ansible-playbook \
	-i ${TERRAFORM_PROJECT_PATH}/inventory.yml \
	-e "@../vars.yml" \
	./playbook-deploy.yml
