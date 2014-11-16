#!/bin/bash

if [ -e "$(pwd)/backup/backup.tar" ]; then
    echo "Backup file exists."
    echo "run '$(pwd)/backup/backup.tar'"
    exit 1
else
    echo "Backup file does not exists."
fi

if [ -e "$(pwd)/backup" ]; then
    echo "Backup directory exists."
else
    echo "Backup directory not exists."
    mkdir $(pwd)/backup
fi

docker run --volumes-from gitbucket-storage -v $(pwd)/backup:/backup nabezokodaikon/ubuntu:storage tar cvf /backup/backup.tar /root/.gitbucket

exit 0
