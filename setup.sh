#!/bin/bash

set -eo pipefail

rm -rf assignment

echo "--- Clone student assignment branch"

git clone -b $BRANCH_NAME $COURSE_REPO assignment

echo "--- Clone graded tests"

cd assignment/src

rm -rf test

git clone -b $BRANCH_NAME $GRADING_TESTS_REPO test

cd ../..

echo "+++ Make sure directory structure is correct"

ls -al

docker build -t docker_image_${BUILDKITE_JOB_ID} .




