#!/bin/bash -eux
# Generic
export BUCKET_NAME="${BUCKET_NAME:=ebac-reports}"
export BENCHMARK_NAME="${BENCHMARK_NAME:=AWS_DBT2_RDS}"

# Ansible
export ANSIBLE_VERBOSITY="${ANSIBLE_VERBOSITY:=0}"

# Terraform
export REGION="${REGION:=us-east-1}"
export ZONE0="${ZONE0:=us-east-1b}"
export ZONE1="${ZONE1:=us-east-1c}"
# Benchmarker instance
export DRIVER_INSTANCE_TYPE="${DRIVER_INSTANCE_TYPE:=c5.9xlarge}"
# Postgres Instance
export PG_INSTANCE_TYPE="${PG_INSTANCE_TYPE:=db.r5.8xlarge}"
export PG_STORAGE_TYPE="${PG_STORAGE_TYPE:=io1}"
export PG_STORAGE_SIZE="${PG_STORAGE_SIZE:=4096}"
export PG_STORAGE_IOPS="${PG_STORAGE_IOPS:=64000}"
# Postgres Settings
export PG_ENGINE="${PG_ENGINE:=postgres}"
export PG_VERSION="${PG_VERSION:=14}"

# DBT2
export DBT2_DURATION="${DBT2_DURATION:=10000}"
export DBT2_WAREHOUSE="${DBT2_WAREHOUSE:=3600}"
export DBT2_CONNECTIONS="${DBT2_CONNECTIONS:=72}"
