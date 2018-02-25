#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get install -y software-properties-common
add-apt-repository ppa:vbernat/haproxy-1.8
apt-get update
apt-get install -y haproxy=1.8.\*
