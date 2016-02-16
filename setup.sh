#!/bin/bash

env

set -eo pipefail

echo "--- Clone student assignment branch"

git clone -b $BRANCH_NAME $COURSE_REPO

echo "--- Clone graded tests"

git submodule add $GRADING_TESTS_REPO test

echo "+++ Make sure directory structure is correct"

ls -al



