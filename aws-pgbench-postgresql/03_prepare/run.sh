#!/bin/bash -eux

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_HOST_KEY_CHECKING=false
TERRAFORM_PROJECT_PATH="${RESULTS_DIRECTORY}/${TERRAFORM_PROJECT_NAME}"

# Prepare benchmark
ansible-playbook \
	-i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
	-e "@${SCRIPT_DIR}/../vars.yml" \
	-e "{\"pg_versions\": ${PG_VERSIONS}}" \
	-e "pgbench_scale_factor=${PGBENCH_SCALE_FACTOR}" \
	${SCRIPT_DIR}/playbook-pgbench-init.yml
