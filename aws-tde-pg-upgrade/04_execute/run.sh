#!/bin/bash -eux

SOURCEDIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
TERRAFORM_PROJECT_NAME="terraform"
TERRAFORM_PROJECT_PATH="${SOURCEDIR}/../${TERRAFORM_PROJECT_NAME}"
RESULTS_DIRECTORY="${SOURCEDIR}/../results"

export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_ARGS="-o ForwardX11=no -o UserKnownHostsFile=/dev/null"
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_HOST_KEY_CHECKING=false

# Run the pg_upgrade benchmark with TDE and without TDE
ansible-playbook \
    -u ${SSH_USER} \
    --private-key ${TERRAFORM_PROJECT_PATH}/ssh-id_rsa \
    -i "${SOURCEDIR}/../inventory.yml" \
    -e "@$SOURCEDIR/../environment.yml" \
    -e "@$SOURCEDIR/../vars.yml" \
    -e "results_directory=${RESULTS_DIRECTORY}/report-data" \
    "${SOURCEDIR}/playbook-pg-upgrade-timing.yml"

# Copy infrastructure.yml and vars.yml
cp "../infrastructure.yml" "$RESULTS_DIRECTORY"
cp "../vars.yml" "$RESULTS_DIRECTORY"
