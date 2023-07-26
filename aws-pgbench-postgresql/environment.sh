#!/bin/bash -eux
# Generic
export BUCKET_NAME="${BUCKET_NAME:=ebac-reports}"
export BENCHMARK_NAME="${BENCHMARK_NAME:=AWS_PGBENCH_POSTGRESQL}"

# Ansible
export ANSIBLE_VERBOSITY="${ANSIBLE_VERBOSITY:=0}"

# Terraform
export REGION="${REGION:=us-east-1}"
export ZONE0="${ZONE0:=us-east-1b}"
# Postgres Instance
export PG_INSTANCE_TYPE="${PG_INSTANCE_TYPE:=c5d.18xlarge}" # Assumes attached storage devices from instance type
export PG_IMAGE_NAME="${PG_IMAGE_NAME:=Rocky-8-ec2-8.6-20220515.0.x86_64}"
export PG_IMAGE_OWNER="${PG_IMAGE_OWNER:=679593333241}"
export PG_SSH_USER="${PG_SSH_USER:=rocky}"

# PGBench
export PG_VERSIONS="${PG_VERSIONS:=['15.3','14.8','13.11','12.15','11.20','10.23','9.6.24']}"
export PGBENCH_MODE="${PG_BENCHMODE:=read-write}"
export PGBENCH_SCALE_FACTOR="${PGBENCH_SCALE_FACTOR:=20000}"
export CLIENT_END_DURATION="${CLIENT_END_DURATION:=400}"
export BENCHMARK_DURATION="${BENCHMARK_DURATION:=1200}"
