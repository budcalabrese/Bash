#!/bin/bash

# pointing to the directory that contains the text file
MYPATH="/home/usr/bud"

# Pulling information from Nginx reverse proxy
# Pulling the lines that have server in field 1 and the domain nmae in field 2
for server in $(awk '$1~/server/ && $2~/stripdomainname/ {print $2}' ${MYPATH}/routes.conf); do
 host=${server%:*}
 port=${server##*:}
 # printing to the screen
 echo ${host} $(host ${host} | awk '{print $NF}') ${port//;/}
done