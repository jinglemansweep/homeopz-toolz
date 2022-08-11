#!/bin/bash

if [ -z "${ANSIBLE_VAULT_PASSWORD}" ]; then
  echo "ANSIBLE_VAULT_PASSWORD environment variable not set!"
  exit 2
fi

echo "${ANSIBLE_VAULT_PASSWORD}"
