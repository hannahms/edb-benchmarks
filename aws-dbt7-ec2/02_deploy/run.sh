#!/bin/bash -eux

SOURCEDIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
TERRAFORM_PROJECT_NAME="terraform"
TERRAFORM_PROJECT_PATH="${SOURCEDIR}/../${TERRAFORM_PROJECT_NAME}"

export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_SSH_ARGS="-o ForwardX11=no -o UserKnownHostsFile=/dev/null"
export ANSIBLE_HOST_KEY_CHECKING=false

ansible-playbook \
    -i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
    -e "@$SOURCEDIR/../environment.yml" \
    -e "@$SOURCEDIR/../credentials.yml" \
    "${SOURCEDIR}/playbook-deploy.yml"
