#!/bin/bash -eux

SOURCEDIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
TERRAFORM_PROJECT_NAME="terraform"
TERRAFORM_PROJECT_PATH="${SOURCEDIR}/../${TERRAFORM_PROJECT_NAME}"

TPA_BIN_DIR=/opt/2ndQuadrant/TPA/bin
export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_ARGS="-o ForwardX11=no -o UserKnownHostsFile=/dev/null"
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_HOST_KEY_CHECKING=false

# Create the TPA directory
mkdir -p ${SOURCEDIR}/tpa

# TPA configuration
TPA_DIR=${SOURCEDIR}/tpa
mv ${SOURCEDIR}/config.yml ${TPA_DIR}/.
mv ${SOURCEDIR}/edb-repo-creds.txt ${TPA_DIR}/.
chmod 0600 ${TPA_DIR}/edb-repo-creds.txt
export EDB_REPO_CREDENTIALS_FILE=${TPA_DIR}/edb-repo-creds.txt

${TPA_BIN_DIR}/tpaexec relink ${TPA_DIR}
${TPA_BIN_DIR}/tpaexec provision ${TPA_DIR}

# Setup file systems
ansible-playbook \
    -i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
    -e "@$SOURCEDIR/../environment.yml" \
    -e "@$SOURCEDIR/../vars.yml" \
    "${SOURCEDIR}/playbook-setup-fs.yml"

# TPA deployment
${TPA_BIN_DIR}/tpaexec deploy ${TPA_DIR}

ansible-playbook \
    -i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
    -e "@$SOURCEDIR/../environment.yml" \
    -e "@$SOURCEDIR/../vars.yml" \
    "${SOURCEDIR}/playbook-deploy.yml"

ansible-playbook \
    -i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
    -e "@$SOURCEDIR/../environment.yml" \
    -e "@$SOURCEDIR/../vars.yml" \
    "${SOURCEDIR}/playbook-hammerdb-setup.yml"
