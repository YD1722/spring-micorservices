#!/bin/bash

# Method to build the Docker image for a service
function buildServiceImage() {
  local service=$1
  local rootDir=$2

  echo "Building submodule: $service"
  cd "$rootDir/$service"
  mvn clean install -DskipTests

  # Point the current shell to the minikube docker engine
  eval $(minikube docker-env)

  # Build the Docker image
  docker build -t "k8/$service:latest" .
}

currentDir=$(pwd)
rootDir=$(dirname "$(dirname "$currentDir")")

# Declare the SERVICES array
services=(
  "gateway"
  "gallery-service"
  #  "image-service"
  #  "image-processing-service"
)

#Build Docker images for services
for service in "${services[@]}"; do
  buildServiceImage "$service" "$rootDir"
done
