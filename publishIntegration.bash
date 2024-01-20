#!/usr/bin/env bash

apt update && apt install jq -y 

echo '{"person":{"name":"John", "age":30, "city":"New York"}}' | jq '.person.name'
# urlUsCentral1="https://stagingqualuscentral1-integrations-googleapis.sandbox.google.com/v1"
# publishURI="projects/standalone-ip-prod-testing/locations/us-central1/integrations/deep-connector-demo-config/versions/$1"

#  curl -v -X GET -H "Content-Type: application/json" "$urlUsCentral1/$publishURI:downloadJsonPackage?files=INTEGRATION" -H "Authorization: Bearer $(gcloud auth print-access-token)";
