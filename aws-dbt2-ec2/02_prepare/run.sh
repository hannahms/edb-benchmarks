#!/bin/bash -eux

export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_HOST_KEY_CHECKING=false

# FIXME: use absolute path to vars.yml
ansible-playbook \
	-i "${TERRAFORM_PROJECT_PATH}/${TERRAFORM_PROJECT_NAME}/inventory.yml" \
	-e "@../vars.yml" \
	-e "dbt2_warehouse=${DBT2_WAREHOUSE}" \
	./playbook-dbt2-build-db.yml
