#!/bin/bash

set -eo pipefail


echo "--- Delete old assignments folders"
rm -rf */

echo "--- Iterate over student repos"
IFS=",";

declare -a repoArray
declare -a SHAarray

repoArray=($STUDENTS_REPOS)
SHAarray=($SHA1_OF_COMMITS)

#repors are:
echo ${repoArray[0]}
echo ${repoArray[1]}
#shas are :
echo ${SHAarray[0]}
echo ${SHAarray[1]}

repoLength=${#repoArray[@]}
shalength=${#SHAarray[@]}

for (( i=0; i<repoLength; i++ ))
do
    git clone -b $BRANCH_NAME ${repoArray[i]}
    folder=$(basename ${repoArray[i]} .git)
    cd $folder
    git reset --hard ${SHAarray[i]}
    cd ..
done

echo "--- Run mosstest ruby file"
ruby mosstest.rb


