#!/bin/bash -eux
# Generic
export BUCKET_NAME="${BUCKET_NAME:=ebac-reports}"
export BENCHMARK_NAME="${BENCHMARK_NAME:=AWS_HAMMERDB_TPROCC_C_ORACLE}"

# Ansible
export ANSIBLE_VERBOSITY="${ANSIBLE_VERBOSITY:=0}"

# Terraform
export SSH_USER="${SSH_USER:=rocky}"
export REGION="${REGION:=us-east-1}"
export ZONE0="${ZONE0:=us-east-1b}"
export ZONE1="${ZONE1:=us-east-1c}"
# Benchmarker instance
export DRIVER_INSTANCE_TYPE="${DRIVER_INSTANCE_TYPE:=c5.9xlarge}"
# Database Instance
export DB_ENGINE="${DB_ENGINE:=oracle-ee}"
export DB_VERSION="${DB_VERSION:=19}"
export DB_INSTANCE_TYPE="${DB_INSTANCE_TYPE:=db.r5.8xlarge}"
export DB_STORAGE_TYPE="${DB_STORAGE_TYPE:=io2}"
export DB_STORAGE_PROPERTIES="${DB_STORAGE_PROPERTIES:=io2}"
export DB_STORAGE_SIZE="${DB_STORAGE_SIZE:=300}"
export DB_STORAGE_IOPS="${DB_STORAGE_IOPS:=15000}"

# TPROCC
export TPROCC_DURATION="${TPROCC_DURATION:=60}"
export TPROCC_WAREHOUSE="${TPROCC_WAREHOUSE:=2000}"
export TPROCC_VUSERS="${TPROCC_VUSERS:=60}"
