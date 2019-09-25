unless Vagrant.has_plugin?('vagrant-hostmanager')
    system("vagrant plugin install #{'vagrant-hostmanager'}")
    system("echo 'New plugins installed. Restarting Vagrant setup.'")
    exec "vagrant #{ARGV.join ' '}"
end

require 'vagrant-hostmanager'
Vagrant.configure(2) do |config|

  # Set base box and provisioning
  config.vm.box = "ubuntu/bionic64"
  config.vm.provision :shell, path: "bootstrap.sh"
  #config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network :private_network, ip: '192.168.10.12'
  #config.vm.network :private_network, ip: "192.168.68.8"
 
  # Provider resources
  config.vm.provider "virtualbox" do |v|
    v.name = "devbox.bah.com"
    v.memory = 1024
    v.cpus = 2
  end
 
  # Networking
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.vm.hostname = 'devbox.bah.com'
  config.vm.provision :shell, :inline => "apt-get update --fix-missing"
  config.vm.provision :shell, :inline => "sudo DEBIAN_FRONTEND=noninteractive apt-get install -q -y python3 python3-pip"
  config.vm.provision :shell, :inline => "sudo DEBIAN_FRONTEND=noninteractive echo 'alias python=/usr/bin/python3' >> /home/vagrant/.bashrc"
  config.vm.provision :shell, :inline => "sudo DEBIAN_FRONTEND=noninteractive echo 'alias pip=/usr/bin/pip3' >> /home/vagrant/.bashrc"
  #config.vm.network :private_network, ip: '192.168.10.12'
  config.vm.network :forwarded_port, guest: 80, host: 8080
  # Shared folder
  config.vm.synced_folder '.', '/Users/syedahmed/DEVOPS/TOOLS/VAGRANT/UBUNTU/vagrant-apache/vagrant'
end
