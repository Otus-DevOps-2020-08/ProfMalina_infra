#!/bin/bash
BRANCH=${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}

if [ "$BRANCH" == "master" ]; then
	DOCKER_CHECK=`docker ps --format '{{.Names}}'`
	echo $DOCKER_CHECK
	if $DOCKER_CHECK; then
		echo Docker running
	else
		docker network create hw-test-net
		docker run -d -v $(pwd):/srv -v /var/run/docker.sock:/tmp/docker.sock \
			-e DOCKER_HOST=unix:///tmp/docker.sock --cap-add=NET_ADMIN -p 33433:22 --privileged \
			--device /dev/net/tun --name hw-test --network hw-test-net express42/otus-homeworks:0.7.1
		# Show versions & run tests
		docker exec hw-test bash -c 'echo -=Get versions=-; ansible --version; ansible-lint --version; packer version; terraform version; tflint --version; docker version; docker-compose --version'
	fi
    docker exec hw-test bash -c 'config-scripts/tests.sh'
else
    echo "Tests canceled"
fi
