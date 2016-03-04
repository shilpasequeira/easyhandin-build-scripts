#!/bin/bash

set -eo pipefail

IFS=', ' read -r -a repoArray <<< $STUDENTS_REPOS

for element in "${repoArray[@]}"
do
   git clone -b $BRANCH_NAME element
done

git clone https://github.com/shilpasequeira/easyhandin-build-scripts.git

cd easyhandin-build-scripts

ruby moss.rb