#!/bin/bash -eux

RUNDIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")")

# We need the absolute path of $TERRAFORM_PROJECT_PATH in this script.
TERRAFORM_PROJECT_PATH="../terraform"

edb-terraform generate \
		--cloud-service-provider aws \
		--project-name terraform \
		--work-path "${TERRAFORM_PROJECT_PATH}" \
		--user-templates "${RUNDIR}/templates" \
		--infra-file "${RUNDIR}/../infrastructure.yml"
cd "${TERRAFORM_PROJECT_PATH}"
terraform init
terraform apply -auto-approve

mkdir -p "${RESULTS_DIRECTORY}"
# .tfstate might contain secrets
# ssh short term keys currently used
# .terraform created at run-time and controlled by terraform CLI
rsync --archive \
		--exclude="*tfstate*" \
		--exclude="*ssh*" \
		--exclude=".terraform/" \
		--recursive \
		./ \
		"${RESULTS_DIRECTORY}"
