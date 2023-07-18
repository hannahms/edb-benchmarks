#!/bin/bash -eux

SOURCEDIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
TERRAFORM_PROJECT_NAME="terraform"
TERRAFORM_PROJECT_PATH="${SOURCEDIR}/../${TERRAFORM_PROJECT_NAME}"

export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_ARGS="-o ForwardX11=no -o UserKnownHostsFile=/dev/null"
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_HOST_KEY_CHECKING=false

python3 ${SOURCEDIR}/build-inventory.py ${TERRAFORM_PROJECT_PATH}
mv ${SOURCEDIR}/inventory.yml ${SOURCEDIR}/../.

ansible-playbook \
	-u ${SSH_USER} \
	--private-key ${TERRAFORM_PROJECT_PATH}/ssh-id_rsa \
	-i ${SOURCEDIR}/../inventory.yml \
	-e "@${SOURCEDIR}/../vars.yml" \
	-e "repo_username=${EDB_REPO_USERNAME}" \
	-e "repo_password=${EDB_REPO_PASSWORD}" \
	${SOURCEDIR}/playbook-deploy.yml

ansible-playbook \
	-u ${SSH_USER} \
	--private-key ${TERRAFORM_PROJECT_PATH}/ssh-id_rsa \
	-i ${SOURCEDIR}/../inventory.yml \
	-e "@${SOURCEDIR}/../vars.yml" \
	${SOURCEDIR}/playbook-hammerdb-setup.yml
