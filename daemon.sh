#!/bin/bash

docker stop etherpad
docker rm etherpad
docker run -d \
--name etherpad \
-p 8081:9001 \
-v ${PWD}/settings.json:/etc/settings.json \
etherpad $1
