#!/bin/bash

service_name=$1

pwd
ls

docker build --build-arg SERVICE_NAME="$service_name" -t "$service_name" .gitlab
docker tag "$service_name":latest 008744601422.dkr.ecr.ap-south-1.amazonaws.com/"$service_name":latest