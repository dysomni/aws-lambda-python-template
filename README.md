# AWS Lambda Ruby Template
This repo is a template for deploying a ruby lambda function on AWS. Great if all you need is simple authentication, gem dependancies, and JSON responses.

## Requirements

 - The AWS CLI installed on your local development machine
 - An AWS bucket for uploading your source code
	 - *If you would like to skip using the bucket, reference the
   [update-function-code](https://docs.aws.amazon.com/cli/latest/reference/lambda/update-function-code.html) command for the AWS CLI and update the needed arguments to upload the zip file directly within the `config/deploy.sh` script*
 - Ruby 2.7
 - Bundler

## Getting started

 1. Create a Lambda function from the AWS console or CLI. Make sure it
    has the default permissions for a Lambda, unless you plan on
    utilizing the AWS SDK from within your function.
 2. Set up a new trigger for the lambda function. Chose the API gateway
    and use default settings. Note the URL for testing purposes.
 3. Copy over the sample env file to `.env` and fill in the relevant
    fields. (ensure runtime variables such as AUTH are defined within the Lambda environment)
 4. Add gems and code
 5. Deploy using `yarn deploy`
 6. Pass authentication to the API endpoint within the "Authentication" HTTP header as raw, non-encoded text
