#!/bin/bash -eux

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TERRAFORM_PROJECT_NAME="terraform"
TERRAFORM_PROJECT_PATH="../${TERRAFORM_PROJECT_NAME}"
TERRAFORM_PLAN_FILENAME="terraform.plan"

# edb-terraform saves a backup of infrastructure.yml in <project-name>/infrastructure.yml.bak
#   this also includes the edb-terraform version used to generate the files
edb-terraform generate --project-name ${TERRAFORM_PROJECT_NAME} \
                       --work-path ../ \
                       --infra-file ../infrastructure.yml \
                       --cloud-service-provider aws
cd "${TERRAFORM_PROJECT_PATH}"

# .terraform.lock.hcl will be saved here by terraform to lock provider versions and can be reused
terraform init

# Save terraform plan for inspection/reuse
terraform plan -out="$TERRAFORM_PLAN_FILENAME"

# terraform.tfstate/.tfstate.backup will be left around since we use short-term credentials
terraform apply -auto-approve "$TERRAFORM_PLAN_FILENAME"

# copy files into results directory
mkdir -p "${RESULTS_DIRECTORY}" && \ 
rsync --archive \
      --exclude='*tfstate*' \ # might contain secrets
      --exclude='*ssh*' \ # short term keys currently used but can be long term
      --exclude='.terraform/' \ # created at run-time and controlled by terraform
      --recursive \
      ./ \
      "$RESULTS_DIRECTORY/terraform"
