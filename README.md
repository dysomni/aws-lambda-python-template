# AWS Lambda Python Template
This repo is a template for deploying a python lambda function on AWS. Great if all you need is simple authentication, dependancies, and JSON responses.

## Requirements

 - The AWS CLI installed on your local development machine
 - Python 3.9
 - Docker
 - Terraform

## Tech Notes
 - In this repo I use us-east-1. Change where necessary.

## Getting started

 1. Copy over the sample env file to `.env` and fill in the relevant
    fields.
 2. Add packages with pipenv and code
 3. Clone [this repo](https://github.com/dysomni/aws-sam-build-images) to store your own build images for python. Make sure your docker cli is logged in with your aws credentials. Create a private repository in AWS ECR if you haven't already named `[insert aws account id here].dkr.ecr.us-east-1.amazonaws.com/aws-sam-cli-build-image-python3.9`. Then use the command `make build_python39`.
 4. Deploy using `make deploy`
 5. Pass authentication to the API endpoint within the "Authentication" HTTP header as raw, non-encoded text
