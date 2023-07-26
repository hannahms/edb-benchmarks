#!/bin/bash -eux
# Generic
export BUCKET_NAME="${BUCKET_NAME:=ebac-reports}"
export BENCHMARK_NAME="${BENCHMARK_NAME:=AWS_TDE_PG_UPGRADE}"

# Credentials
export REPO_USERNAME="${REPO_USERNAME:=<secret>}"
export REPO_PASSWORD="${REPO_PASSWORD:=<secret>}"

# Ansible
export ANSIBLE_VERBOSITY="${ANSIBLE_VERBOSITY:=0}"

# Terraform
export SSH_USER="${SSH_USER:=rocky}"
export REGION="${REGION:=us-east-1}"
export ZONE0="${ZONE0:=us-east-1b}"
# Postgres Instance
export PG_INSTANCE_TYPE="${PG_INSTANCE_TYPE:=c5d.12xlarge}" # Assumes attached storage devices from instance type

# TPCC
export TPCC_WAREHOUSE="${TPCC_WAREHOUSE:=2000}"
export TPCC_LOADER_VUSERS="${TPCC_LOADER_VUSERS:=75}"
