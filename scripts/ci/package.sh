#!/bin/bash

source .env

cd build

rm "../${AWS_LAMBDA_NAME}.zip"
files=$(ls -1A .)
zip -r9 ../${AWS_LAMBDA_NAME}.zip $files
