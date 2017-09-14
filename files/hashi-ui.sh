#!/bin/bash

HASHI_UI_VERSION=0.18.0
HASHI_UI_ARCH=linux-amd64

echo "Getting hashi-ui binary"
wget -q https://github.com/jippi/hashi-ui/releases/download/v${HASHI_UI_VERSION}/hashi-ui-${HASHI_UI_ARCH} -O /tmp/hashi-ui-${HASHI_UI_ARCH}
chmod 0755 /tmp/hashi-ui-${HASHI_UI_ARCH}
mv /tmp/hashi-ui-${HASHI_UI_ARCH} /usr/local/bin/hashi-ui
cp /vagrant/supervisor.hashi-ui.conf /etc/supervisor/conf.d/hashi-ui.conf

mkdir -p /var/log/hashi-ui

supervisorctl reread
supervisorctl update hashi-ui
