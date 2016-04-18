#!/bin/bash

set -eo pipefail

rm -rf assignment

echo "--- Getting the repositories from easyhandin"

#submission_repos="`wget -qO- $SUBMISSION_REPOS_URL`"
submission_repos=$SUBMISSION_REPOS_JSON

count=$(echo $submission_repos | jq "length")

echo "--- Iterate over submission repos"
for((i=0; i<count; i++))
 do
    repo=$(echo $submission_repos | jq --raw-output '.['${i}'].repo')
    git clone $repo assignment
    cd assignment
    git remote add skeleton $SKELETON_REPO
    git fetch skeleton
    git checkout -b $BRANCH_NAME skeleton/$SKELETON_BRANCH_NAME
    git push origin $BRANCH_NAME
    cd ..
    rm -rf assignment
done
