CHANGED_SERVICES=$(git diff --name-only origin/master...HEAD | awk -F/ '/^service-/ {print $1}' | sort -u)

# Ensure at least one value in the matrix
if [ -z "$CHANGED_SERVICES" ]; then
  echo '{ "include": [{ "service": "none" }] }' > changed-services.json
else
  echo '{ "include": [' > changed-services.json
  for service in $CHANGED_SERVICES; do
    echo "{ \"service\": \"$service\" }," >> changed-services.json
  done
  sed -i '$ s/,$//' changed-services.json
  echo ']}' >> changed-services.json
fi
