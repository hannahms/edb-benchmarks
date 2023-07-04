#!/bin/bash -eux

RUNDIR=$(readlink -f "${BASH_SOURCE[0]}")
RUNDIR=$(dirname "$RUNDIR")

TERRAFORM_PROJECT_PATH="${RESULTS_DIRECTORY}/${TERRAFORM_PROJECT_NAME}"
TERRAFORM_PLAN_FILENAME="terraform.plan"

# set biganimal project id in infrastructure.yml
sed -i "s/<PROJECT_ID>/${BA_PROJECT_ID}/g" ${RUNDIR}/../infrastructure.yml
# edb-terraform saves a backup of infrastructure.yml in <project-name>/infrastructure.yml.bak
#   this also includes the edb-terraform version used to generate the files
edb-terraform generate --project-name ${TERRAFORM_PROJECT_NAME} \
                       --work-path ${RESULTS_DIRECTORY} \
                       --infra-file ${RUNDIR}/../infrastructure.yml \
                       --user-templates ${RUNDIR}/templates/inventory.yml.tftpl \
                       --cloud-service-provider aws
# reset biganimal project id for reuse and edb-terraform creates infrastructure.yml.bak within the project directory
sed -i "s/${BA_PROJECT_ID}/<PROJECT_ID>/g" ${RUNDIR}/../infrastructure.yml
cd "${TERRAFORM_PROJECT_PATH}"

# .terraform.lock.hcl will be saved here by terraform to lock provider versions and can be reused
terraform init

# Save terraform plan for inspection/reuse
terraform plan -out="$TERRAFORM_PLAN_FILENAME"

# terraform.tfstate/.tfstate.backup will be left around since we use short-term credentials
terraform apply -auto-approve "$TERRAFORM_PLAN_FILENAME"
