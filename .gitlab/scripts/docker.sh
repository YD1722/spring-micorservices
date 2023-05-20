#!/bin/bash

for service_dir in artifacts/*; do
  if [ -d "$service_dir" ]; then
    service_name=$(basename "$service_dir")
    tag="$service_name:latest"
    ecr_tag="008744601422.dkr.ecr.ap-south-1.amazonaws.com/$service_name:latest"

    # Print the service name
    echo "Service Name: $service_name"

    # Build the Docker image with the provided SERVICE_NAME as a build argument
    docker build --build-arg SERVICE_NAME="$service_name" -t "$tag" "$service_dir"

    # Tag the Docker image dynamically
    docker tag "$tag" "$ecr_tag"
  fi
done
