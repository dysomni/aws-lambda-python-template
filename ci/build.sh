#!/bin/bash

rm -rf build
mkdir build
cp -r lib/ build/lib/
cp lambda_function.py build/lambda_function.py
pip install -r requirements.txt --target build/lib/packages
