#!/bin/bash

VAULT_VERSION=0.8.1
VAULT_ARCH=linux_amd64

echo "Getting vault binary"
wget -q https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_${VAULT_ARCH}.zip -O /tmp/vault_${VAULT_VERSION}_${VAULT_ARCH}.zip
cd /tmp
unzip -o /tmp/vault_${VAULT_VERSION}_${VAULT_ARCH}.zip
mv vault /usr/local/bin/vault

mkdir -p /var/log/vault
mkdir -p /etc/vault
mkdir -p /var/vault

cp /vagrant/supervisor.vault.conf /etc/supervisor/conf.d/vault.conf

supervisorctl reread
supervisorctl update vault

sleep 5

export VAULT_ADDR=http://127.0.0.1:8200
TOKEN=$(grep 'Root Token' /var/log/vault/out | tail -n1 | awk '{print $3}')
echo $TOKEN | vault auth -
vault token-create -id="1e9e1f5a-3c23-a5d2-d308-ed2c3dd541c4"
vault auth 1e9e1f5a-3c23-a5d2-d308-ed2c3dd541c4
vault policy-write secret /vagrant/acl.hcl
vault write /auth/token/roles/nomad-cluster @/vagrant/nomad-cluster-role.json
vault policy-write nomad-server /vagrant/nomad-server-policy.hcl
echo -n "12345" | vault write secret/password value=-
