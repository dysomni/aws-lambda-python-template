registry_id=$(shell aws ecr describe-registry | jq '.registryId' -r)

repl:
	pipenv run ipython

install:
	pipenv install

ci/prep:
	pipenv install
	pipenv requirements > requirements.txt

ci/build: ci/prep
	docker run \
		--rm -v $(PWD):/var/layer \
		-w /var/layer \
		$(registry_id).dkr.ecr.us-east-1.amazonaws.com/aws-sam-cli-build-image-python3.9:arm64 \
		./ci/build.sh

ci/push:
	./ci/deploy.sh

ci/deploy: ci/build ci/push