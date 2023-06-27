#!/bin/bash -eux

RUNDIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")")

# We need the absolute path of $TERRAFORM_PROJECT_PATH in this script.
TERRAFORM_PROJECT_PATH=$(realpath "${TERRAFORM_PROJECT_PATH}")

edb-terraform generate \
		--cloud-service-provider aws \
		--project-name terraform \
		--work-path "${TERRAFORM_PROJECT_PATH}" \
		--user-templates "${RUNDIR}/templates" \
		--infra-file "${RUNDIR}/../infrastructure.yml"
cd "${TERRAFORM_PROJECT_PATH}/terraform"
terraform init
terraform apply -auto-approve
