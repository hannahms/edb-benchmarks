#!/bin/bash -eux
# Push HammerDB files to the S3 bucket
date=$(date +'%Y-%m-%dT%H:%M:%S')

# Upload benchmark data
aws s3 cp "$RESULTS_DIRECTORY/" s3://${BUCKET_NAME}/${BENCHMARK_NAME}/${date}/ --recursive
