# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = 2
FILE_DISK = './tmp/large_disk.vdi'
GIGA_SIZE = 2
DISK_SIZE = 20


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 config.vm.box = "precise64"


 config.vm.provider "virtualbox" do |vb|
 vb.gui = false
 vb.memory = 1024 * GIGA_SIZE

 vb.customize ['createhd', '--filename', FILE_DISK, '--size', DISK_SIZE * 1024]
 vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', FILE_DISK]
 end

 config.vm.network "public_network", bridge: 'en0: Ethernet'

 #config.vm.network "private_network", ip: "10.10.3.88",
 #virtualbox__intnet: true

 config.vm.hostname = "myChefTestServer"

 config.vm.provision "chef_solo" do |chef|
 	chef.add_recipe "createuser"
 	chef.add_recipe "xmledit"
# 	chef.add_recipe "updatexml"
 end
 
end