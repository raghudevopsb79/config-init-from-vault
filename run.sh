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
vault kv get roboshop-${ENV}/${APP_NAME} | sed -n '/Data/, $ p' | sed -e '1,3 d' | awk '{print $1"="$2}' >/tmp/secret
mkdir -p secrets
for i in `cat /tmp/secret`; do
  SECRET=$(echo $i | awk -F = '{print $1}')
  VALUE=$(echo $i | awk -F = '{print $2}')
  echo -n $VALUE >/secrets/$SECRET
done
kubectl delete secret $APP_NAME
kubectl create secret generic $APP_NAME --from-file=./secrets

