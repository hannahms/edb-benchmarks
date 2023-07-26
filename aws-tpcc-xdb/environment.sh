#!/bin/bash -eux
# Generic
export BUCKET_NAME="${BUCKET_NAME:=ebac-reports}"
export BENCHMARK_NAME="${BENCHMARK_NAME:=AWS_TPCC_XDB}"

# Credentials
export REPO_USERNAME="${REPO_USERNAME:=<secret>}"
export REPO_PASSWORD="${REPO_PASSWORD:=<secret>}"

# Ansible
export ANSIBLE_VERBOSITY="${ANSIBLE_VERBOSITY:=0}"

# Terraform
export SSH_USER="${SSH_USER:=rocky}"
export REGION="${REGION:=us-east-1}"
export ZONE0="${ZONE0:=us-east-1b}"
export ZONE1="${ZONE1:=us-east-1c}"
# Benchmarker instance
export DRIVER_INSTANCE_TYPE="${DRIVER_INSTANCE_TYPE:=c5.9xlarge}"
# Postgres Instance
export PG_INSTANCE_TYPE="${PG_INSTANCE_TYPE:=c5d.12xlarge}" # Assumes attached storage devices from instance type
export PG_IMAGE_NAME="${PG_IMAGE_NAME:=Rocky-8-ec2-8.6-20220515.0.x86_64}"
export PG_IMAGE_OWNER="${PG_IMAGE_OWNER:=679593333241}"
export PG_SSH_USER="${PG_SSH_USER:=rocky}"
export XDB_INSTANCE_TYPE="${XDB_INSTANCE_TYPE:=c5.4xlarge}" # Assumes attached storage devices from instance type

# TPCC
export TPCC_DURATION="${TPCC_DURATION:=5}"
export TPCC_WAREHOUSE="${TPCC_WAREHOUSE:=2000}"
export TPCC_RAMPUP="${TPCC_RAMPUP:=1}"
export TPCC_LOADER_VUSERS="${TPCC_LOADER_VUSERS:=75}"
export TPCC_MIN_VUSERS="${TPCC_MIN_VUSERS:=1}"
export TPCC_MAX_VUSERS="${TPCC_MAX_VUSERS:=14}"
export TPCC_STEP_VUSERS="${TPCC_STEP_VUSERS:=1}"
