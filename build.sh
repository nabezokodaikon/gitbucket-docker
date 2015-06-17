#!/bin/bash

GITBUCKET_CONF_FILE="${PWD}/gitbucket.conf"
GITBUCKET_HOST=`ip addr show eth0 | grep -o 'inet [0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' | grep -o [0-9].*`
GITBUCKET_PORT=52201

cat << EOF > $GITBUCKET_CONF_FILE 
#`date`
gravatar=true
ssh=false
ldap_authentication=false
notification=false
allow_account_registration=false
base_url=https\\://${GITBUCKET_HOST}\\:${GITBUCKET_PORT}
EOF

docker build -t nabezokodaikon/ubuntu:gitbucket .

rm $GITBUCKET_CONF_FILE

exit 0
