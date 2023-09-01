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
    "${SOURCEDIR}/playbook-setup-sync-repl.yml"

mkdir -p "${RESULTS_DIRECTORY}/report-data"
for CONNECTIONS in $(seq "${DBT2_CONNECTIONS_MIN}" "${DBT2_CONNECTIONS_STEP}" \
		"${DBT2_CONNECTIONS_MAX}"); do
	ansible-playbook \
		-i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
		-e "@$SOURCEDIR/../environment.yml" \
		-e "@$SOURCEDIR/../vars.yml" \
		-e "terraform_project_path=${TERRAFORM_PROJECT_PATH}" \
		-e "results_directory=${RESULTS_DIRECTORY}/report-data" \
		-e "connections=${CONNECTIONS}" \
		-e "dbt2_results=/tmp/r${CONNECTIONS}" \
		-e "ts_sysstat=/tmp/sysstat-${CONNECTIONS}" \
		-e "ts_dbstat=/tmp/dbstat-${CONNECTIONS}" \
		"${SOURCEDIR}/playbook-execute.yml"
done

ansible-playbook \
    -i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
    -e "@$SOURCEDIR/../environment.yml" \
    -e "@$SOURCEDIR/../vars.yml" \
	-e "results_directory=${RESULTS_DIRECTORY}" \
    "${SOURCEDIR}/playbook-save.yml"
