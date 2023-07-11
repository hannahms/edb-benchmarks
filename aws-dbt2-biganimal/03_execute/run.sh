#!/bin/bash -eux

export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_HOST_KEY_CHECKING=false
export TERRAFORM_PROJECT_PATH="../terraform"


# Run the benchmark
ansible-playbook \
	-i ${TERRAFORM_PROJECT_PATH}/inventory.yml \
	-e "@../vars.yml" \
	-e "dbt2_duration=${DBT2_DURATION}" \
	-e "dbt2_warehouse=${DBT2_WAREHOUSE}" \
	-e "dbt2_connections=${DBT2_CONNECTIONS}" \
	-e "terraform_project_path=${TERRAFORM_PROJECT_PATH}" \
	-e "results_directory=${RESULTS_DIRECTORY}/dbt2-data" \
	./playbook-dbt2-run.yml

# Copy infrastructure.yml and vars.yml
cp ../infrastructure.yml "$RESULTS_DIRECTORY/dbt2-data"
cp ../vars.yml "$RESULTS_DIRECTORY/dbt2-data"
