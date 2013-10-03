#!/bin/bash

# remove first : (colon) for debug
#while getopts ":u:h:k:f:" opt
while getopts "u:h:k:f:" opt
do
    case $opt in
    u) user=$OPTARG;;
    h) host=$OPTARG;;
    k) key=$OPTARG;;
    f) field=$OPTARG;;
    *) exit 1;;
    esac
done

if [ -z $key ]; then key=/home/$user/.ssh/id_rsa; fi
if [ ! -r $key ]; then error=true; fi

if [ $error ]; then echo -n "U"; exit; fi

ret=$(ssh -i $key $user@$host lssystemstats | grep ^$field | awk '{print $2}')

echo -n $ret