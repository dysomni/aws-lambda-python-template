#!/bin/bash

source .env

terraform -chdir=tf apply

rm -r ./build
