#!/bin/bash

source .env

terraform -chdir=tf init -migrate-state \
  -backend-config="bucket=${TF_STATE_S3_BUCKET}" \
  -backend-config="dynamodb_table=${TF_STATE_DYNAMODB_TABLE}" \
  -backend-config="key=${AWS_LAMBDA_NAME}/terraform.tfstate"
terraform -chdir=tf apply

rm -r ./build
