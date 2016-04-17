#!/bin/bash

set -eo pipefail

echo "--- Getting the repositories from easyhandin"
student_repos="`wget -qO- $STUDENT_REPOS_URL`"
count=$(echo $student_repos | jq "length")

echo "--- Iterate over student repos"
for((i=0; i<count; i++))
 do
    repo=$(echo $student_repos | jq --raw-output '.['${i}'].repo')
    git clone $repo assignment
    cd assignment
    git remote add skeleton $SKELETON_REPO
    git fetch skeleton
    git checkout -b $BRANCH_NAME skeleton/$BRANCH_NAME
    git push origin $BRANCH_NAME
    cd ..
    rm -rf assignment
done
