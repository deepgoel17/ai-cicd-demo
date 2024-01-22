#!/usr/bin/env bash

urlUsCentral1="https://stagingqualuscentral1-integrations-googleapis.sandbox.google.com/v1"
urlUsEast1="https://stagingqualuseast1-integrations-googleapis.sandbox.google.com/v1"

downloadURI="projects/standalone-ip-staging-testing/locations/us-east1/integrations/cicd-demo/versions/$1"
uploadURI="projects/standalone-ip-prod-testing/locations/us-central1/integrations/cicd-demo-prod/versions"
publishURI="projects/standalone-ip-prod-testing/locations/us-central1/integrations/cicd-demo-prod/versions"


downloadResponse=$(curl -v -X GET -H "Content-Type: application/json" "$urlUsEast1/$downloadURI:download?fileFormat=JSON" -H "Authorization: Bearer $(gcloud auth print-access-token)")

echo "$downloadResponse"

echo "$downloadResponse" > integration.json 

uploadResponse=$(curl -v -X POST -H "Content-Type: application/json" "$urlUsCentral1/$uploadURI:upload" -H "Authorization: Bearer $(gcloud auth print-access-token)" -d "$downloadResponse")

echo "$uploadResponse"

versionNumberUpload=$(echo "$uploadResponse" | jq ".integrationVersion.name" | cut -d'/' -f8 | cut -d '"' -f1)

echo "$versionNumberUpload"

publishResponse=$(curl -v -X POST -H "Content-Type: application/json" "$urlUsCentral1/$publishURI/$versionNumberUpload:publish" -H "Authorization: Bearer $(gcloud auth print-access-token)" -d @configParameters.json)

echo "$publishResponse"