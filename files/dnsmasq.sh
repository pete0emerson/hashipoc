#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "Installing dnsmasq"
apt-get install -y -q dnsmasq
cp /vagrant/dnsmasq.conf /etc/dnsmasq.conf
cp /vagrant/dnsmasq.consul /etc/dnsmasq.d/10-consul
service dnsmasq restart
