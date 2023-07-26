#!/bin/bash -eux
# Generic
export BUCKET_NAME="${BUCKET_NAME:=ebac-reports}"
export BENCHMARK_NAME="${BENCHMARK_NAME:=AWS_DBT2_RDS}"

# Credentials
export REPO_USERNAME="${REPO_USERNAME:=<secret>}"
export REPO_PASSWORD="${REPO_PASSWORD:=<secret>}"

# Ansible
export ANSIBLE_VERBOSITY="${ANSIBLE_VERBOSITY:=0}"

# Terraform
export SSH_USER="${SSH_USER:=rocky}"
export REGION="${REGION:=us-east-1}"
export ZONE0="${ZONE0:=us-east-1b}"
# Benchmarker instance
export DRIVER_INSTANCE_TYPE="${DRIVER_INSTANCE_TYPE:=m5.2xlarge}"
# Postgres Instance
export PG_INSTANCE_TYPE="${PG_INSTANCE_TYPE:=c5.2xlarge}"
export PG_STORAGE_TYPE="${PG_STORAGE_TYPE:=io2}"
export PG_STORAGE_SIZE="${PG_STORAGE_SIZE:=1500}"
export PG_STORAGE_IOPS="${PG_STORAGE_IOPS:=32000}"

# DBT2
export DBT2_DURATION="${DBT2_DURATION:=10000}"
export DBT2_WAREHOUSE="${DBT2_WAREHOUSE:=3600}"
export DBT2_CONNECTIONS="${DBT2_CONNECTIONS:=72}"
