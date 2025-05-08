#!/bin/bash

# Get the list of changed directories under the monorepo root
CHANGED_SERVICES=$(git diff --name-only origin/master...HEAD | awk -F/ '/^service-/ {print $1}' | sort -u)

# If there are no changes, create an empty JSON file
if [ -z "$CHANGED_SERVICES" ]; then
  echo '{ "include": [] }' > changed-services.json
else
  echo '{ "include": [' > changed-services.json
  for service in $CHANGED_SERVICES; do
    echo "{ \"service\": \"$service\" }," >> changed-services.json
  done
  sed -i '$ s/,$//' changed-services.json  # Remove last comma
  echo ']}' >> changed-services.json
fi
