#!/bin/bash

NOMAD_VERSION=0.6.2
NOMAD_ARCH=linux_amd64

echo "Getting nomad binary"
wget -q https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_${NOMAD_ARCH}.zip -O /tmp/nomad_${NOMAD_VERSION}_${NOMAD_ARCH}.zip
cd /tmp
unzip -o /tmp/nomad_${NOMAD_VERSION}_${NOMAD_ARCH}.zip
mv nomad /usr/local/bin/nomad

mkdir -p /var/log/nomad
mkdir -p /etc/nomad
mkdir -p /var/nomad

cp /vagrant/supervisor.nomad.conf /etc/supervisor/conf.d/nomad.conf

supervisorctl reread
supervisorctl update nomad

sleep 5 # Make sure nomad is up and running
