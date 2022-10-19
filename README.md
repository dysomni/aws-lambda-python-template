# AWS Lambda Python Template
This repo is a template for deploying a python lambda function on AWS. Great if all you need is simple authentication, dependancies, and JSON responses.

## Requirements

 - The AWS CLI installed on your local development machine
 - An AWS bucket for uploading your source code
	 - *If you would like to skip using the bucket, reference the
   [update-function-code](https://docs.aws.amazon.com/cli/latest/reference/lambda/update-function-code.html) command for the AWS CLI and update the needed arguments to upload the zip file directly within the `scripts/ci/deploy.sh` script*
 - Python 3.9
 - Docker
 - Terraform

## Tech Notes
 - In this repo I use us-east-1. Change where necessary.

## Getting started

 1. Create a Lambda function from the AWS console or CLI. Make sure it
    has the default permissions for a Lambda, unless you plan on
    utilizing the AWS SDK from within your function. Use ARM architecture.
 2. Create lambda URL
 3. Copy over the sample env file to `.env` and fill in the relevant
    fields.
 4. Add packages with pipenv and code
 5. Clone [this repo](https://github.com/dysomni/aws-sam-build-images) to store your own build images for python. Make sure your docker cli is logged in with your aws credentials. Create a private repository in AWS ECR if you haven't already named `[insert aws account id here].dkr.ecr.us-east-1.amazonaws.com/aws-sam-cli-build-image-python3.9`. Then use the command `make build_python39`.
 6. Deploy using `make deploy`
 7. Pass authentication to the API endpoint within the "Authentication" HTTP header as raw, non-encoded text
