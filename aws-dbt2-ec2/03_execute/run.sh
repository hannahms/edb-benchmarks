#!/bin/bash -eux

export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_HOST_KEY_CHECKING=false

# Run the benchmark
# FIXME: use absolute path to vars.yml
ansible-playbook \
	-i "${TERRAFORM_PROJECT_PATH}/${TERRAFORM_PROJECT_NAME}/inventory.yml" \
	-e "@../vars.yml" \
	-e "dbt2_duration=${DBT2_DURATION}" \
	-e "dbt2_warehouse=${DBT2_WAREHOUSE}" \
	-e "dbt2_connections=${DBT2_CONNECTIONS}" \
	-e "terraform_project_path=${TERRAFORM_PROJECT_PATH}" \
	-e "terraform_project_name=${TERRAFORM_PROJECT_NAME}" \
	-e "results_directory=${RESULTS_DIRECTORY}" \
	./playbook-dbt2-run.yml

tar -C "${RESULTS_DIRECTORY}" --strip-components=1 \
		-xf "${RESULTS_DIRECTORY}/dbt2-data.tar.gz"
rm "${RESULTS_DIRECTORY}/dbt2-data.tar.gz"
