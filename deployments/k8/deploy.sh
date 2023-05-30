#!/bin/bash

function deployService() {
  local service=$1
  local currentDir=$2

  echo "Deploying service: $service"
  cd "$currentDir/$service"

  kubectl delete -f deployment.yaml
  kubectl delete -f service.yaml

  kubectl create -f deployment.yaml
  kubectl create -f service.yaml
}

# Get the current directory
currentDir=$(pwd)

services=(
  "gateway"
  "gallery-service"
  #  "image-service"
  #  "image-processing-service"
)

# Deploy services to Kubernetes
for service in "${services[@]}"; do
  deployService "$service" "$currentDir"
done
