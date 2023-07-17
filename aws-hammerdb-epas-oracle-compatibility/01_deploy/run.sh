#!/bin/bash -eux

SOURCEDIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
TERRAFORM_PROJECT_NAME="terraform"
TERRAFORM_PROJECT_PATH="${SOURCEDIR}/../${TERRAFORM_PROJECT_NAME}"

export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_ARGS="-o ForwardX11=no -o UserKnownHostsFile=/dev/null"
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_HOST_KEY_CHECKING=false

ansible-playbook \
	-i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
	-e "@${SOURCEDIR}/../vars.yml" \
	-e "terraform_project_path=${TERRAFORM_PROJECT_PATH}" \
	-e "repo_username=${REPO_USERNAME}" \
	-e "repo_password=${REPO_PASSWORD}" \
	-e "tprocc_duration=${TPROCC_DURATION}" \
	-e "tprocc_vusers=${TPROCC_VUSERS}" \
	-e "tprocc_warehouse=${TPROCC_WAREHOUSE}" \
	"${SOURCEDIR}/playbook-deploy.yml"
