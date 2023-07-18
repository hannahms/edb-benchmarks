#!/bin/bash -eux

SOURCEDIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
TERRAFORM_PROJECT_NAME="terraform"
TERRAFORM_PROJECT_PATH="${SOURCEDIR}/../${TERRAFORM_PROJECT_NAME}"
TERRAFORM_PLAN_FILENAME="terraform.plan"
RESULTS_DIRECTORY="${SOURCEDIR}/../results"

echo "PGBENCH_SCALE_FACTOR: $PGBENCH_SCALE_FACTOR"

if (( $(echo "$PGBENCH_SCALE_FACTOR < 100" | bc -l) )); then
   echo "PGBENCH_SCALE_FACTOR: $PGBENCH_SCALE_FACTOR";
   echo "PGBench Scale Factor, cannot be lower than 100!"
   exit 1
fi
