#!/bin/bash -eux

SOURCEDIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
TERRAFORM_PROJECT_NAME="terraform"
TERRAFORM_PROJECT_PATH="${SOURCEDIR}/../${TERRAFORM_PROJECT_NAME}"
RESULTS_DIRECTORY="${SOURCEDIR}/../results"

export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_HOST_KEY_CHECKING=false

# Run the benchmark
# FIXME: use absolute path to vars.yml
ansible-playbook \
	-i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
	-e "@${SOURCEDIR}/../vars.yml" \
	-e "dbt2_duration=${DBT2_DURATION}" \
	-e "dbt2_warehouse=${DBT2_WAREHOUSE}" \
	-e "dbt2_connections=${DBT2_CONNECTIONS}" \
	-e "terraform_project_path=${TERRAFORM_PROJECT_PATH}" \
	-e "results_directory=${RESULTS_DIRECTORY}" \
	"${SOURCEDIR}/playbook-dbt2-run.yml"

tar -C "${RESULTS_DIRECTORY}" --strip-components=1 \
		-xf "${RESULTS_DIRECTORY}/dbt2-data.tar.gz"
rm "${RESULTS_DIRECTORY}/dbt2-data.tar.gz"
