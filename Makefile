registry_id=$(shell aws ecr describe-registry | jq '.registryId' -r)

repl:
	pipenv run ipython

install:
	pipenv install

prep:
	pipenv install
	pipenv requirements > requirements.txt

build: prep
	docker run \
		--rm -v $(PWD):/var/layer \
		-w /var/layer \
		$(registry_id).dkr.ecr.us-east-1.amazonaws.com/aws-sam-cli-build-image-python3.9:arm64 \
		./scripts/ci/build.sh

package:
	./scripts/ci/package.sh

deploy: build package
	./scripts/ci/deploy.sh
