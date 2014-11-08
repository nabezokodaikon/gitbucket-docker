#!/bin/bash

if [ -d "${PWD}/data" ]; then
    echo "data directory exists."
else
    echo "data directory create."
    mkdir ${PWD}/data
fi

docker stop gitbucket
docker rm gitbucket
docker stop gitbucket-storage
docker rm gitbucket-storage
docker run --name gitbucket-storage -d -v ${PWD}/data:/root/.gitbucket -t nabezokodaikon/ubuntu:storage echo Data-only container for gitbucket.
docker run --name gitbucket -d -p 127.0.0.1:8080:8080 --volumes-from gitbucket-storage -t nabezokodaikon/ubuntu:gitbucket
