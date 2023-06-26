#!/bin/bash -eux

# We need the absolute path of $TERRAFORM_PROJECT_PATH in this script.
TERRAFORM_PROJECT_PATH=$(realpath "${TERRAFORM_PROJECT_PATH}")

# FIXME: use absolute path to infrastructure.yml
edb-terraform "${TERRAFORM_PROJECT_PATH}" ../infrastructure.yml
cd "${TERRAFORM_PROJECT_PATH}"
terraform init
terraform apply -auto-approve
