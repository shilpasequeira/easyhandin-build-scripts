#!/bin/bash

set -eo pipefail

echo "--- Delete old assignments folders"
rm -rf */

echo "--- Iterate over student repos"
IFS=",";

count=$(jq '.students | length' json.txt)

for((i=0;i<$count;i++))
do
    repo=$(cat json.txt | jq --raw-output '.students['${i}'].repo')
    SHA=$(cat json.txt | jq --raw-output '.students['${i}'].sha')
    git clone -b $BRANCH_NAME $repo
    folder=$(basename $repo .git)
    cd $folder
    git reset --hard $SHA
    cd ..
done

echo "--- Run mosstest ruby file"
ruby mosstest.rb


