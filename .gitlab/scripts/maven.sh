#!/bin/bash

service_name=$1
mvn_goals=${2:-package}

# Navigate to the service directory
cd "$service_name" || exit

# Execute mvn clean $MVN_GOALS
mvn clean "$mvn_goals"
