#!/bin/bash

set -eo pipefail

echo "--- ID"
id

echo "--- Env"
env

echo "--- Docker daemon status"
service docker status

rm -rf assignment

echo "--- Clone student assignment branch"

git clone -b $BRANCH_NAME $COURSE_REPO assignment

echo "--- Clone graded tests"

cd assignment/src

rm -rf test

git clone -b $BRANCH_NAME $GRADING_TESTS_REPO test

cd ../..

echo "+++ Create container and run test"

docker run -v ${BUILDKITE_BUILD_CHECKOUT_PATH}/assignment/:${BUILDKITE_BUILD_CHECKOUT_PATH}/assignment/ -w ${BUILDKITE_BUILD_CHECKOUT_PATH}/assignment/ --rm -i -t maven mvn clean test



