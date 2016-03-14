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

repoLength=${#repoArray[@]}
shalength=${#SHAarray[@]}

for (( i=0; i<repoLength; i++ ))
do
    git clone -b $BRANCH_NAME ${repoArray[i]} student_$i
    cd student_$i
    git reset --hard ${SHAarray[i]}
    cd ..
done


cd ..

echo "--- Run mosstest ruby file"
ruby mosstest.rb


