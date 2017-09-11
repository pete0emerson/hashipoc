#!/bin/bash

cp /vagrant/app.py /usr/local/bin

echo "Running nomad job ..."
nomad run /vagrant/helloworld.nomad

echo "Waiting for the deployment to complete ..."
while ! nomad job status helloworld | grep 'Deployment completed successfully' ; do
    sleep 1
done

ALLOC_ID=$(nomad job status helloworld | grep -A2 Allocations | tail -n1 | awk '{print $1}')
ENDPOINT=$(nomad alloc-status $ALLOC_ID | grep http: | sed 's/^.*http: //')
echo "Curling hello world server at ${ENDPOINT}"
curl -s http://${ENDPOINT}
echo
echo "while [ 1 ] ; do curl http://localhost ; sleep 1 ; done"
