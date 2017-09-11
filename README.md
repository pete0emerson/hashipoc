# Overview

HashiPOC stands for [Hashicorp](https://www.hashicorp.com/) Proof Of Concept. This example uses [Consul](https://www.consul.io/), [consul-template](https://github.com/hashicorp/consul-template),
[Vault](https://www.vaultproject.io/), and [Nomad](https://www.nomadproject.io/) to deploy a sample python application, load balanced with haproxy.

# Prerequisites

* A working [Vagrant](https://www.vagrantup.com/) installation

# Quickstart

Bring the vagrant instance up.

```
vagrant up
```

At the end of the provisioning two instances of the python application will be running via nomad behind haproxy. SSH into the vagrant instance and run a while loop curling localhost:

```
vagrant ssh -c 'while [ 1 ] ; do curl http://localhost ; sleep 1 ; done'
```

# Under the hood

After bringing the Ubuntu Xenial instance up, shell-based provisioning happens.

`base.sh` installs some basic tools: unzip, supervisor, virtualenv, pip, and
installs a pip requirements file.

`haproxy.sh` installs haproxy.

`consul.sh`, `haproxy.sh`, `vault.sh`, and `nomad.sh` install those four packages with supervisor config files to manage their processes. Some vault token generation, policy generation, and secret creation also happens in `vault.sh`.

`consul-template.sh` installs consul-template, which monitors service changes in consul and reconfigures and reloads haproxy accordingly.

`dnsmasq.sh` exposes consul's DNS so that you can do `dig helloworld.service.consul +short SRV` instead of having to point at consul's
DNS to do service discovery.

`application.sh` initiates the nomad command to run the Hello World python code.

# Doing a rolling upgrade

The nomad deployment (`files/helloworld.nomad` locally, `/vagrant/helloworld.nomad` on the vagrant instance) is configured to do a
blue/green style release. Inside this file, change `"v1"` to `"v2"` on line 19. Keep a while loop curling localhost going in another window. Then execute `nomad run /vagrant/helloworld.nomad` on the vagrant instance. You'll see four instances of the application running instead of two (two of which will print out `v2`). If you execute a `nomad deployment list` and grab the deployment id, you can promote it with `nomad deployment promote <ID>`. The old instances will go away, leaving the `v2` instances in place.
