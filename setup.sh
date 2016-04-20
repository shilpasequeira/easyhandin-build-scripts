#!/bin/bash

set -eo pipefail

echo "--- Delete old assignment folder"
rm -rf assignment

echo "--- Clone student assignment branch"
git clone -b $BRANCH_NAME $COURSE_REPO assignment

echo "--- Resetting to SHA within deadline"
cd assignment
git reset --hard $SHA

echo "--- Clone graded tests"
cd src
rm -rf test
git clone -b $BRANCH_NAME $GRADING_TESTS_REPO test

cd ../..

echo "+++ Create container and run test"
docker run -u=$UID -v ${BUILDKITE_BUILD_CHECKOUT_PATH}/assignment/:${BUILDKITE_BUILD_CHECKOUT_PATH}/assignment/ -w ${BUILDKITE_BUILD_CHECKOUT_PATH}/assignment/ --rm -i -t maven mvn clean test
