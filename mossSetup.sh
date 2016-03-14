#!/bin/bash

set -eo pipefail


echo "--- Delete old assignment folder"
rm -rf assignment

echo "--- Create assignment folder"
mkdir assignment

cd assignment

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

#length of repos is:
length=${#repoArray[@]}
echo "length1 is: "$length
#length of shas is:
length2=${#SHAarray[@]}
echo "length2 is: "$length2

for (( i=0; i<length; i++ ))
do
    echo $BRANCH_NAME ${repoArray[i]}
    git clone -b $BRANCH_NAME ${repoArray[i]}
    # reset this repository's master branch to the commit of interest
    git reset --hard ${SHAarray[i]}
    #git checkout HEAD -- <path>
done

cd ..

echo "--- Run mosstest ruby file"
ruby mosstest.rb


