#!/bin/bash -eux

SOURCEDIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
TERRAFORM_PROJECT_NAME="terraform"
TERRAFORM_PROJECT_PATH="${SOURCEDIR}/../${TERRAFORM_PROJECT_NAME}"
RESULTS_DIRECTORY="${SOURCEDIR}/../results"

export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_ARGS="-o ForwardX11=no -o UserKnownHostsFile=/dev/null"
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_HOST_KEY_CHECKING=false
export ANSIBLE_ROLES_PATH="${SOURCEDIR}/../../roles"

ansible-playbook \
    -i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
    -e "@$SOURCEDIR/../environment.yml" \
    -e "@$SOURCEDIR/../vars.yml" \
    -e "@$SOURCEDIR/../credentials.yml" \
    -e "terraform_project_path=${TERRAFORM_PROJECT_PATH}" \
    -e "results_directory=${RESULTS_DIRECTORY}" \
    "${SOURCEDIR}/playbook-execute-baseline.yml"

ansible-playbook \
    -i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
    -e "@$SOURCEDIR/../environment.yml" \
    -e "@$SOURCEDIR/../vars.yml" \
    -e "@$SOURCEDIR/../credentials.yml" \
	  -e "results_directory=${RESULTS_DIRECTORY}/baseline" \
    "${SOURCEDIR}/playbook-save.yml"

ansible-playbook \
	  -i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
	  -e "@$SOURCEDIR/../environment.yml" \
	  -e "@$SOURCEDIR/../vars.yml" \
	  -e "@$SOURCEDIR/../credentials.yml" \
	  -e "terraform_project_path=${TERRAFORM_PROJECT_PATH}" \
	  -e "results_directory=${RESULTS_DIRECTORY}" \
		"${SOURCEDIR}/playbook-enable-group-commit.yml"

ansible-playbook \
	  -i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
	  -e "@$SOURCEDIR/../environment.yml" \
	  -e "@$SOURCEDIR/../vars.yml" \
	  -e "@$SOURCEDIR/../credentials.yml" \
	  -e "terraform_project_path=${TERRAFORM_PROJECT_PATH}" \
	  -e "results_directory=${RESULTS_DIRECTORY}" \
		"${SOURCEDIR}/playbook-execute-group-commit.yml"

ansible-playbook \
    -i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
    -e "@$SOURCEDIR/../environment.yml" \
    -e "@$SOURCEDIR/../vars.yml" \
    -e "@$SOURCEDIR/../credentials.yml" \
	  -e "results_directory=${RESULTS_DIRECTORY}/gc" \
    "${SOURCEDIR}/playbook-save.yml"
