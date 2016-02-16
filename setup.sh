#!/bin/bash

env

set -eo pipefail

echo "--- Clone student assignment branch"

git clone -b $BRANCH_NAME $COURSE_REPO

echo "--- Clone graded tests"

cd src/test

git clone -b $BRANCH_NAME $GRADING_TESTS_REPO

cd ../..

echo "+++ Make sure directory structure is correct"

ls -al



