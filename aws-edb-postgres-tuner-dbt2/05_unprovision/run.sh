#!/bin/bash -eux

TERRAFORM_PROJECT_PATH="../terraform"
cd "${TERRAFORM_PROJECT_PATH}"
terraform destroy -auto-approve
