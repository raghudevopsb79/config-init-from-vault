#!/bin/bash

if [ -z "$VAULT_TOKEN" ]; then
  echo VAULT_TOKEN variable is missing
  exit 1
fi

if [ -z "$VAULT_ADDR" ]; then
  echo $VAULT_ADDR variable is missing
  exit 1
fi

vault login -tls-skip-verify $VAULT_TOKEN


