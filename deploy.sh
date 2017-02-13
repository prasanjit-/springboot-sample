#!/bin/bash

if [ -z "${1}" ]; then
   version="latest"
   marathon="mesos-dev.inframetic.com"
else
   version="${1}"
   marathon="mesos-dev.inframetic.com"
fi

# destroy old application
curl -X DELETE -H "Content-Type: application/json" http://${marathon}:8080/v2/apps/springboot-sample-31047
ssh -t centos@mesos-dev.inframetic.com "sudo su - root -c '/root/devops/scripts/clean_docker' "

# I know this one is ugly. But it works for now.
sleep 6

# these lines will create a copy of app_marathon.json and update the image version
cp -f app_marathon.json app_marathon.json.tmp
sed -i "s/latest/${version}/g" app_marathon.json.tmp

# post the application to Marathon
curl -X POST -H "Content-Type: application/json" http://${marathon}:8080/v2/apps -d@app_marathon.json.tmp
