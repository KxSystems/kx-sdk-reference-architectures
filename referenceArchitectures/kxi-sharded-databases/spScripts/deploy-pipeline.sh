#!/bin/bash

# Usage: ./deploy-pipeline.sh <pipeline-name> <spec-file-path>

set -e

# Input validation
if [[ $# -ne 2 ]]; then
  echo "❌ Usage: $0 <pipeline-name> <spec-file-path>"
  exit 1
fi

PIPELINE_NAME=$1
SPEC_FILE=$2

# Validate spec file exists
if [[ ! -f "$SPEC_FILE" ]]; then
  echo "❌ Spec file not found: $SPEC_FILE"
  exit 1
fi

echo "🚀 Deploying pipeline: $PIPELINE_NAME"
echo "📄 Using spec file: $SPEC_FILE"

# Read the content of the spec file
SPEC_CONTENT=$(<"$SPEC_FILE")

# Create pipeline JSON payload
PAYLOAD=$(jq -n --arg name "$PIPELINE_NAME" --arg spec "$SPEC_CONTENT" '
{
  name: $name,
  type: "spec",
  base: "q",
  config: { content: $spec },
  persistence : {
          controller : { class:"standard", size:"1Gi", checkpointFreq: 5000 },
          worker     : { class:"standard", size:"2Gi", checkpointFreq: 1000 }
        }
}' | jq -asR .)

# Echo payload
echo "📦 Payload being sent:"
echo "$PAYLOAD" | jq .

# Send the request
echo "📡 Sending request to Stream Processor API..."
RESPONSE=$(curl -s -w "\nHTTP_STATUS:%{http_code}" -X POST http://localhost:5000/pipeline/create -d "$PAYLOAD")

# Parse response and status
HTTP_BODY=$(echo "$RESPONSE" | sed -n '1,/HTTP_STATUS:/p' | sed '$d')
HTTP_STATUS=$(echo "$RESPONSE" | tr -d '\n' | sed -e 's/.*HTTP_STATUS://')

if [[ "$HTTP_STATUS" -eq 200 ]]; then
  echo "✅ Pipeline '$PIPELINE_NAME' deployed successfully!"
else
  echo "❌ Failed to deploy pipeline. HTTP Status: $HTTP_STATUS"
  echo "📬 Response: $HTTP_BODY"
  exit 1
fi
