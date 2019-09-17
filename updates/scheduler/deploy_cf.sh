#!/bin/bash

URL=ingest_flights_$(openssl rand -base64 48 | tr -d /=+ | cut -c -32)
echo $URL

sed -i "s/def ingest_flights.*/def ${URL}(request):/" main.py
sed -i "s/URL=ingest_flights_.*/URL=${URL}/" call_cf.sh
sed -i "s/ingest_flights.*/${URL}\"/" setup_cron.sh

gcloud functions deploy $URL --runtime python37 --trigger-http --timeout 480s
