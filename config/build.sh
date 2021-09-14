#!/bin/bash

rm -rf build
mkdir build
cp lambda_function.rb build/lambda_function.rb
cp -r .bundle/ build/.bundle/
cp -r lib/ build/lib/
cp -r vendor/ build/vendor/
cp Gemfile build/Gemfile
cp Gemfile.lock build/Gemfile.lock