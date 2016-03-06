#!/bin/bash

set -eo pipefail


echo "--- Delete old assignment folder"
rm -rf assignment

echo "--- Create assignment folder"
mkdir assignment

cd assignment

echo "--- Iterate over student repos"
IFS=",";

repoArray=($STUDENTS_REPOS)

echo ${repoArray[0]}
echo ${repoArray[1]}

for element in $repoArray
do
   echo $BRANCH_NAME $element
   git clone -b $BRANCH_NAME $element
done

cd ..

echo "--- Run mosstest ruby file"
ruby mosstest.rb


