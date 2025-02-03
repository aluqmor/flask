
Vagrant.configure("2") do |config|
  config.vbguest.auto_update = false
  config.vm.box = "debian/bullseye64"
  config.vm.network "private_network", ip: "192.168.57.30"
  config.vm.provision "shell", privileged: false, path: "provision.sh"
end
# Algunos comandoas de la provision hay que hacerlos manualmente pero los dejo como referencia