#!/bin/bash -eux
# Generic
export BUCKET_NAME="${BUCKET_NAME:=ebac-reports}"
export BENCHMARK_NAME="${BENCHMARK_NAME:=AWS_TDE_PG_UPGRADE}"

# Credentials
export EDB_REPO_USERNAME="${EDB_REPO_USERNAME:=<secret>}"
export EDB_REPO_PASSWORD="${EDB_REPO_PASSWORD:=<secret>}"

# Ansible
export ANSIBLE_VERBOSITY="${ANSIBLE_VERBOSITY:=0}"

# Terraform
export SSH_USER="${SSH_USER:=rocky}"

# TPCC
export TPCC_WAREHOUSE="${TPCC_WAREHOUSE:=2000}"
export TPCC_LOADER_VUSERS="${TPCC_LOADER_VUSERS:=75}"
