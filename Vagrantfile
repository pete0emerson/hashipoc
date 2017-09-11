Vagrant.configure("2") do |config|
  config.vm.box = "xenial"
  config.vm.synced_folder "files", "/vagrant"
  config.vm.provision "shell", path: "files/base.sh"
  config.vm.provision "shell", path: "files/consul.sh"
  config.vm.provision "shell", path: "files/haproxy.sh"
  config.vm.provision "shell", path: "files/consul-template.sh"
  config.vm.provision "shell", path: "files/dnsmasq.sh"
  config.vm.provision "shell", path: "files/vault.sh"
  config.vm.provision "shell", path: "files/nomad.sh"
  config.vm.provision "shell", path: "files/application.sh"
end
