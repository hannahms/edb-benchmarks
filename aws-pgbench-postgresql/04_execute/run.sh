#!/bin/bash -eux

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_HOST_KEY_CHECKING=false
TERRAFORM_PROJECT_PATH="../terraform"

# Execute the playbook for each PostgreSQL version
versions=($(echo $PG_VERSIONS | tr -d '[],'))
max_version=${versions[0]}

mkdir -p "${RESULTS_DIRECTORY}/report-data"

for version in "${versions[@]}"
do
	# Execute benchmark
	ansible-playbook \
		-i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
		-e "@${SCRIPT_DIR}/../vars.yml" \
		-e "pg_version=${version}" \
		-e "pg_max_version=${max_version}" \
		-e "pgbench_mode=${PGBENCH_MODE}" \
		-e "client_end_duration=${CLIENT_END_DURATION}" \
		-e "benchmark_duration=${BENCHMARK_DURATION}" \
		-e "results_directory=${RESULTS_DIRECTORY}/report-data" \
		${SCRIPT_DIR}/playbook-pgbench-run.yml

	# Process results
	ansible-playbook \
		-i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
		-e "@${SCRIPT_DIR}/../vars.yml" \
		-e "pg_version=${version}" \
		-e "results_directory=${RESULTS_DIRECTORY}/report-data" \
		"${SCRIPT_DIR}/playbook-pgbench-process.yml"
done

# Copy infrastructure.yml and vars.yml
cp "../infrastructure.yml" "$RESULTS_DIRECTORY/report-data"
cp "../vars.yml" "$RESULTS_DIRECTORY/report-data"
