#!/bin/bash -eux
# Push DBT2 files to the S3 bucket
cd "$RESULTS_DIRECTORY"
date=$(date +'%Y-%m-%dT%H:%M:%S')

# Upload benchmark data
aws s3 cp ./ s3://${BUCKET_NAME}/${BENCHMARK_NAME}/${date}/ --recursive
