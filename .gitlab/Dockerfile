#!/bin/bash

for service_dir in artifacts/*; do
  if [ -d "$service_dir" ]; then
    service_name=$(basename "$service_dir")
    tag="$service_name:latest"
    ecr_tag="008744601422.dkr.ecr.ap-south-1.amazonaws.com/$service_name:latest"

    # Create the Dockerfile
    dockerfile_content="FROM openjdk:17-alpine\nMAINTAINER yashodha.dev.space\nCOPY $service_name/$service_name.jar app.jar\nENTRYPOINT [\"java\", \"-jar\", \"/app.jar\"]"
    echo -e "$dockerfile_content" > Dockerfile

    # Build the Docker image
    docker build \
      --build-arg SERVICE_NAME="$service_name" \
      --tag "$tag" \
      .

    # Tag the Docker image dynamically
    docker tag "$tag" "$ecr_tag"

    # Clean up the Dockerfile
    rm Dockerfile
  fi
done
