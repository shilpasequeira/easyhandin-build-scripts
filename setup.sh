#!/bin/bash

set -eo pipefail

echo "--- Delete old assignment folder"
rm -rf assignment

echo "--- Clone student assignment branch"
git clone -b $BRANCH_NAME $COURSE_REPO assignment

cd assignment/src

echo "-- Delete student unit tests"
rm -rf test

echo "--- Clone graded tests"
git clone -b $BRANCH_NAME $GRADING_TESTS_REPO test

cd test
git reset --hard $SHA
cd ../../..

echo "+++ Create container and run test"
docker run -u=$UID -v ${BUILDKITE_BUILD_CHECKOUT_PATH}/assignment/:${BUILDKITE_BUILD_CHECKOUT_PATH}/assignment/ -w ${BUILDKITE_BUILD_CHECKOUT_PATH}/assignment/ --rm -i -t maven mvn clean test



