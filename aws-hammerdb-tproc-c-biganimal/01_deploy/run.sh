#!/bin/bash -eux

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_HOST_KEY_CHECKING=false
TERRAFORM_PROJECT_PATH="${RESULTS_DIRECTORY}/${TERRAFORM_PROJECT_NAME}"

ansible-playbook \
	-i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
	-e "@../vars.yml" \
	-e "tprocc_duration=${TPROCC_DURATION}" \
	-e "tprocc_vusers=${TPROCC_VUSERS}" \
	-e "tprocc_warehouse=${TPROCC_WAREHOUSE}" \
	-e "terraform_project_path=${TERRAFORM_PROJECT_PATH}" \
	./playbook-deploy.yml
