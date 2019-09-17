#!/bin/bash

REGION='us-central1'
PROJECT=$(gcloud config get-value project)
BUCKET=dsongcp_20190914
URL=ingest_flights_Fk3rjEC11ZyoFZJ08B4QgP5nhl2gTQOX
TOKEN=gyaudsha08p39phlcudai73hur929449ks

echo {\"year\":\"2015\"\,\"month\":\"03\"\,\"bucket\":\"${BUCKET}\", \"token\":\"${TOKEN}\"} > /tmp/message
cat /tmp/message

curl -X POST "https://${REGION}-${PROJECT}.cloudfunctions.net/$URL" -H "Content-Type:application/json" --data-binary @/tmp/message

