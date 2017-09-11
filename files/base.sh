#!/bin/bash

apt-get update

echo "Installing unzip"
apt-get install -y -q unzip

echo "Installing supervisor"
apt-get install -y -q supervisor
apt-get install -y virtualenv python-pip
pip install -r /vagrant/requirements.txt
