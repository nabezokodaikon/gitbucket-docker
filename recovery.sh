#!/bin/bash

if [ -e "${PWD}/backup/backup.tar" ]; then
    echo "Backup file exists."
else
    echo "Backup file does not exists."
    exit 1
fi

deleteId=$(docker run -d --volumes-from gitbucket-storage -t nabezokodaikon/ubuntu:storage rm -rf /root/.gitbucket)
docker rm ${deleteId}

recoveryId=$(docker run -d --volumes-from gitbucket-storage -v $(pwd)/backup:/backup -t nabezokodaikon/ubuntu:storage tar xvf backup/backup.tar)
docker rm ${recoveryId}

exit 0
