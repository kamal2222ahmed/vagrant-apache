unless Vagrant.has_plugin?('vagrant-hostmanager')
    system("vagrant plugin install #{'vagrant-hostmanager'}")
    system("echo 'New plugins installed. Restarting Vagrant setup.'")
    exec "vagrant #{ARGV.join ' '}"
end

require 'vagrant-hostmanager'
Vagrant.configure(2) do |config|

  # Set base box and provisioning
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell, path: "bootstrap.sh"
  #config.vm.network "forwarded_port", guest: 80, host: 80
 
  # Provider resources
  config.vm.provider "virtualbox" do |v|
    v.name = "devbox.spacewalk.dev"
    v.memory = 1024
    v.cpus = 2
  end
 
  # Networking
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.vm.hostname = 'devbox.spacewalk.dev'
  config.vm.network :private_network, ip: '192.168.10.12'
  #config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network :forwarded_port, guest: 80, host: 8080
  # Shared folder
  #config.vm.synced_folder '.', '/Users/a3x52zz/DEVOPS/TOOLS/VAGRANT/UBUNTU/vagrant-apache/vagrant'
 
end
