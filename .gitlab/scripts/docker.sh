#!/bin/bash

for service_dir in artifacts/*; do
  if [ -d "$service_dir" ]; then
    service_name=$(basename "$service_dir")
    tag="$service_name:latest"
    ecr_tag="008744601422.dkr.ecr.ap-south-1.amazonaws.com/$service_name:latest"

    # Build the Docker image with the provided SERVICE_NAME as a build argument
    docker build --build-arg SERVICE_NAME="$service_name" -t "$tag" -f .gitlab/Dockerfile .

    # Tag the Docker image dynamically
    docker tag "$tag" "$ecr_tag"
  fi
done
