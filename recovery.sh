#!/bin/bash

if [ -e "$(pwd)/backup/backup.tar" ]; then
    echo "Backup file exists."
else
    echo "Backup file does not exists."
    exit 1
fi

docker run --volumes-from gitbucket-storage nabezokodaikon/ubuntu:storage rm -rf /root/.gitbucket/*
docker run --volumes-from gitbucket-storage -v $(pwd)/backup:/backup nabezokodaikon/ubuntu:storage tar xvf /backup/backup.tar

exit 0
