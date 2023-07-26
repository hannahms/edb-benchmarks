#!/bin/bash -eux
# Generic
export BUCKET_NAME="${BUCKET_NAME:=ebac-reports}"
export BENCHMARK_NAME="${BENCHMARK_NAME:=AWS_TPCC_REFDATA}"

# Credentials
export REPO_USERNAME="${REPO_USERNAME:=<secret>}"
export REPO_PASSWORD="${REPO_PASSWORD:=<secret>}"

# Ansible
export ANSIBLE_VERBOSITY="${ANSIBLE_VERBOSITY:=0}"

# Terraform
export REGION="${REGION:=us-east-1}"
export ZONE0="${ZONE0:=us-east-1b}"
# Benchmarker instance
export DRIVER_INSTANCE_TYPE="${DRIVER_INSTANCE_TYPE:=c5.9xlarge}"
# Postgres Instance
export PG_INSTANCE_TYPE="${PG_INSTANCE_TYPE:=c5d.12xlarge}" # Assumes attached storage devices from instance type
export PG_IMAGE_NAME="${PG_IMAGE_NAME:=Rocky-8-ec2-8.6-20220515.0.x86_64}"
export PG_IMAGE_OWNER="${PG_IMAGE_OWNER:=679593333241}"
export PG_SSH_USER="${PG_SSH_USER:=rocky}"

# TPCC
export TPCC_DURATION="${TPCC_DURATION:=20}"
export TPCC_WAREHOUSE="${TPCC_WAREHOUSE:=2000}"
export TPCC_RAMPUP="${TPCC_RAMPUP:=1}"
export TPCC_LOADER_VUSERS="${TPCC_LOADER_VUSERS:=75}"
export TPCC_VUSERS="${TPCC_VUSERS:=75}"
