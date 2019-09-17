#!/bin/bash

REGION='us-central1'
PROJECT=$(gcloud config get-value project)
BUCKET=dsongcp_20190914

URL="https://${REGION}-${PROJECT}.cloudfunctions.net/ingest_flights_Fk3rjEC11ZyoFZJ08B4QgP5nhl2gTQOX"
TOKEN="gyaudsha08p39phlcudai73hur929449ks"
echo {\"bucket\":\"${BUCKET}\", \"token\":\"${TOKEN}\"} > /tmp/message

gcloud pubsub topics create cron-topic
gcloud pubsub subscriptions create cron-sub --topic cron-topic

# details => https://cloud.google.com/sdk/gcloud/reference/scheduler/jobs/create/http?hl=ja
gcloud scheduler jobs create http monthlyupdate \
       --schedule="8 of month 10:00" \
       --uri=$URL \
       --max-backoff=7d \
       --max-retry-attempts=5 \
       --max-retry-duration=3h \
       --min-backoff=1h \
       --time-zone="US/Eastern" \
       --message-body-from-file=/tmp/message \
       --headers='Content-Type=application/json'

