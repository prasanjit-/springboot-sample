#!/bin/bash
### build.sh
echo Running script as user - `whoami`
if [ -z "${1}" ]; then
   version="latest"
else
   version="${1}"
fi
#
mvn clean package docker:build
docker tag springio/gs-spring-boot-docker:latest mesos-dev.inframetic.com:5000/gs-spring-boot-docker:latest
