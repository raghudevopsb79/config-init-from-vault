#!/bin/bash

if [ -z "$VAULT_TOKEN" ]; then
  echo VAULT_TOKEN variable is missing
  exit 1
fi

if [ -z "$VAULT_ADDR" ]; then
  echo VAULT_ADDR variable is missing
  exit 1
fi

if [ -z "$ENV" ]; then
  echo ENV variable is missing
  exit 1
fi

if [ -z "$APP_NAME" ]; then
  echo APP_NAME variable is missing
  exit 1
fi


vault login -tls-skip-verify $VAULT_TOKEN &>/dev/null
tail -f /dev/null
vault kv get roboshop-${ENV}/${APP_NAME} | sed -n '/Data/, $ p' | sed -e '1,3 d' | awk '{print "export "$1"="$2}' >/data/secrets
cat /data/secrets

