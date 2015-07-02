#!/usr/bin/env bash

docker rmi $(docker images | awk '/^<none>/ { print $3 }')
