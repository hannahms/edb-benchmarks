#!/bin/bash -eux

SOURCEDIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
TERRAFORM_PROJECT_NAME="terraform"
TERRAFORM_PROJECT_PATH="${SOURCEDIR}/../${TERRAFORM_PROJECT_NAME}"
TERRAFORM_PLAN_FILENAME="terraform.plan"
RESULTS_DIRECTORY="${SOURCEDIR}/../results"

edb-terraform generate \
		--cloud-service-provider aws \
		--project-name "${TERRAFORM_PROJECT_NAME}" \
		--work-path "${TERRAFORM_PROJECT_PATH}" \
		--user-templates "${SOURCEDIR}/templates" \
		--infra-file "${SOURCEDIR}/../infrastructure.yml"
cd "${TERRAFORM_PROJECT_PATH}"
terraform init

# Save terraform plan for inspection/reuse
terraform plan -out="$TERRAFORM_PLAN_FILENAME"

# terraform.tfstate/.tfstate.backup will be left around since we use short-term credentials
terraform apply -auto-approve "$TERRAFORM_PLAN_FILENAME"

mkdir -p "${RESULTS_DIRECTORY}"
# .tfstate might contain secrets
# ssh short term keys currently used
# .terraform created at run-time and controlled by terraform CLI
rsync --archive \
		--exclude="*tfstate*" \
		--exclude="*ssh*" \
		--exclude=".terraform/" \
		--recursive \
		"${TERRAFORM_PROJECT_PATH}" \
		"${RESULTS_DIRECTORY}"
