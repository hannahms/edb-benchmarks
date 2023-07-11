#!/bin/bash -eux
# Push DBT-2 results to the S3 bucket

date=$(date +'%Y-%m-%dT%H:%M:%S')

aws s3 cp "${RESULTS_DIRECTORY}" \
		"s3://${BUCKET_NAME}/${BENCHMARK_NAME}/${date}/" --recursive
