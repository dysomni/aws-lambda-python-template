#!/bin/bash

cd build

rm "../${AWS_LAMBDA_NAME}.zip"
files=$(ls -1A .)
zip -r9 ../${AWS_LAMBDA_NAME}.zip $files

cd ..

aws s3 cp "${AWS_LAMBDA_NAME}.zip" \
  "s3://${AWS_BUCKET_NAME}/${AWS_BUCKET_PATH}/${AWS_LAMBDA_NAME}.zip"
aws lambda update-function-code \
  --function-name "${AWS_LAMBDA_NAME}" \
  --s3-bucket "${AWS_BUCKET_NAME}" \
  --s3-key "${AWS_BUCKET_PATH}/${AWS_LAMBDA_NAME}.zip"