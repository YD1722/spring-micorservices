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

# Method to deploy a service to Kubernetes
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

# Set the project directory two folders up from the current directory
rootDir=$(dirname "$(dirname "$currentDir")")

# Declare the SERVICES array
services=(
  "gateway"
  "gallery-service"
  #  "image-service"
  #  "image-processing-service"
)

#Build Docker images for services
#for service in "${services[@]}"; do
#  buildServiceImage "$service" "$rootDir"
#done

kubectl create namespace wierd-arts

# Deploy services to Kubernetes
for service in "${services[@]}"; do
  deployService "$service" "$currentDir"
done
