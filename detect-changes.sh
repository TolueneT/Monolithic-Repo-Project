#!/bin/bash

# Get the list of changed directories under the monorepo root
CHANGED_SERVICES=$(git diff --name-only origin/main...HEAD | \
  awk -F/ '/^service-/ {print $1}' | sort -u)

# Create a JSON array for matrix generation
echo "{ \"include\": [" > changed-services.json
for service in $CHANGED_SERVICES; do
  echo "{ \"service\": \"$service\" }," >> changed-services.json
done
sed -i '$ s/,$//' changed-services.json  # remove last comma
echo "]}" >> changed-services.json
