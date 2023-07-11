#!/bin/bash -eux

RUNDIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")")

# We need the absolute path of $TERRAFORM_PROJECT_PATH in this script.
TERRAFORM_PROJECT_PATH="${RESULTS_DIRECTORY}"

edb-terraform generate \
		--cloud-service-provider aws \
		--project-name terraform \
		--work-path "${TERRAFORM_PROJECT_PATH}" \
		--user-templates "${RUNDIR}/templates" \
		--infra-file "${RUNDIR}/../infrastructure.yml"
cd "${TERRAFORM_PROJECT_PATH}/${TERRAFORM_PROJECT_NAME}"
terraform init
terraform apply -auto-approve
