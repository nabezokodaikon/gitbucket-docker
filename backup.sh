#!/bin/bash
docker run --volumes-from gitbucket-storage -v $(pwd):/backup nabezokodaikon/ubuntu:storage tar cvf /backup/backup.tar /root/.gitbucket
