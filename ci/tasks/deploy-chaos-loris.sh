#!/usr/bin/env bash
set -e

if [[ -z $VAULT_ADDR || -z $VAULT_TOKEN || \
      -z $FOUNDATION_NAME ]]; then
  echo "Error: one the following environment variables is not set: "
  echo ""
  echo "                 VAULT_ADDR"
  echo "                 VAULT_TOKEN"
  echo "                 FOUNDATION_NAME"
  echo ""
  exit 1
fi

export VAULT_HASH_PASSWORD=secret/cf-$FOUNDATION_NAME-password
export VAULT_HASH_PROPS=secret/cf-$FOUNDATION_NAME-props

echo "Getting values from Vault on $VAULT_ADDR"
echo "Password Vault Hash:   $VAULT_HASH_PASSWORD"
echo "Props Vault Hash:      $VAULT_HASH_PROPS"

CF_SYSTEM_DOMAIN=$(vault read -field=system-domain $VAULT_HASH_PROPS)
echo "CF System Domain:      $CF_SYSTEM_DOMAIN"

CF_ADMIN_PASSWORD=$(vault read -field=admin-password $VAULT_HASH_PASSWORD)
echo "CF Admin Password:     $CF_ADMIN_PASSWORD"


