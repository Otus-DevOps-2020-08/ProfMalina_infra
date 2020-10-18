#!/bin/bash
BRANCH=${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}
if [ "$BRANCH" == "master" ]; then
    docker exec hw-test bash -c 'config-scripts/tests.sh'
else
    echo "Tests canceled"
fi
