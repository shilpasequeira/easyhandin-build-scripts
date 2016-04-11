#!/bin/bash

set -eo pipefail

echo "--- Delete old assignments folders"
rm -rf */

echo "--- cloning skeleton code"
git clone -b $BRANCH_NAME $SKELETON_REPO skeletonFolder

echo "--- Getting the repositories and SHAs from easyhandin"
submission_repo_sha="`wget -qO- $SUBMISSION_URL`"
count=$(echo $submission_repo_sha | jq "length")

echo "--- Iterate over student repos"
for((i=0; i<count; i++))
 do
    repo=$(echo $submission_repo_sha | jq --raw-output '.['${i}'].repo')
    Sha=$(echo $submission_repo_sha | jq --raw-output '.['${i}'].sha')
    git clone -b $BRANCH_NAME $repo
    folder=$(basename $repo .git)
    cd $folder
    git reset --hard $Sha
    cd ..
done

echo "--- Run mosstest ruby file"
ruby mosstest.rb
