#!/bin/bash -eux

SOURCEDIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
TERRAFORM_PROJECT_NAME="terraform"
TERRAFORM_PROJECT_PATH="${SOURCEDIR}/../${TERRAFORM_PROJECT_NAME}"

export ANSIBLE_PIPELINING=true
export ANSIBLE_SSH_PIPELINING=true
export ANSIBLE_SSH_ARGS="-o ForwardX11=no -o UserKnownHostsFile=/dev/null"
export ANSIBLE_HOST_KEY_CHECKING=false

( \
	cd "${TERRAFORM_PROJECT_PATH}" && \
	tpaexec configure demo0 --architecture PGD-Always-ON --platform bare \
		--postgresql 15 --pgd-proxy-routing local \
)
cp -p ${TERRAFORM_PROJECT_PATH}/config.yml \
		${TERRAFORM_PROJECT_PATH}/ssh_config \
		${TERRAFORM_PROJECT_PATH}/demo0/
cp -p ${TERRAFORM_PROJECT_PATH}/ssh-id_rsa \
		${TERRAFORM_PROJECT_PATH}/demo0/id_demo0
cp -p ${TERRAFORM_PROJECT_PATH}/ssh-id_rsa.pub \
		${TERRAFORM_PROJECT_PATH}/demo0/id_demo0.pub

(cd "${TERRAFORM_PROJECT_PATH}" && tpaexec deploy demo0)

ansible-playbook \
    -i "${TERRAFORM_PROJECT_PATH}/inventory.yml" \
    -e "@$SOURCEDIR/../environment.yml" \
    -e "@$SOURCEDIR/../credentials.yml" \
    "${SOURCEDIR}/playbook-deploy.yml"
