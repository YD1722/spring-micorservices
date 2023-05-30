#!/bin/bash

service_name=$1
mvn_goal=$2
mvn_args="${@:3}"

# Navigate to the service directory
cd "$service_name" || exit

mvn clean "$mvn_goal" "$mvn_args"
