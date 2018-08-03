#!/bin/bash
clear

if [ -z "$1" ] ; then
    echo "Please pass the name of the AMI"
    exit 1
fi

ami="${1}"

declare -a aminame=($(aws ec2 describe-images --image-ids $ami --query 'Images[*].[Name]' | jq '.[0][0]' | tr -d '"'))
declare -a regions=($(aws ec2 describe-regions --output json | jq '.Regions[].RegionName' | tr -d '"'))

echo $aminame

for r in "${regions[@]}" ; do
    ami=$(aws ec2 describe-images --query 'Images[*].[ImageId]' --filters "Name=name,Values=${aminame}" --region $r --output json | jq '.[0][0]' | tr -d '"')
    echo "$r = ${ami}"
done


#How To Run
#./amitoname.sh aminumber