#!/bin/bash -eux
# Generic
export BUCKET_NAME="${BUCKET_NAME:=ebac-reports}"
export BENCHMARK_NAME="${BENCHMARK_NAME:=AWS_TPCC_TDE_MEDIUM_AMD}"

# Credentials
export REPO_USERNAME="${REPO_USERNAME:=<secret>}"
export REPO_PASSWORD="${REPO_PASSWORD:=<secret>}"

# Ansible
export ANSIBLE_VERBOSITY="${ANSIBLE_VERBOSITY:=0}"

# Terraform
export SSH_USER="${SSH_USER:=rocky}"

# TPCC
export TPCC_DURATION="${TPCC_DURATION:=20}"
export TPCC_WAREHOUSE="${TPCC_WAREHOUSE:=2000}"
export TPCC_RAMPUP="${TPCC_RAMPUP:=1}"
export TPCC_VUSERS="${TPCC_VUSERS:=75}"
