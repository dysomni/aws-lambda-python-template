#!/bin/bash

source .env

terraform -chdir=tf init -backend-config="bucket=${AWS_LAMBDA_NAME}-tf-state" -backend-config="dynamodb_table=${AWS_LAMBDA_NAME}-tf-lock"
terraform -chdir=tf apply

rm -r ./build
