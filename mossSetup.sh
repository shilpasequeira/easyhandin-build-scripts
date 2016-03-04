#!/bin/bash

set -eo pipefail

echo "--- Delete old assignment folder"
rm -rf assignment

echo "--- Create assignment folder"
mkdir assignment

cd assignment

IFS=',' read -r -a repoArray <<< $STUDENTS_REPOS

echo ${repoArrayp[0] repoArray[1]}

for element in $repoArray
do
   echo $BRANCH_NAME $element
   git clone -b $BRANCH_NAME $element

done

ls

ruby mosstest.rb

cd ..

