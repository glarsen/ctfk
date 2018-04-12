# -*- mode: ruby -*-
# vi: set ft=ruby :

# Specify Vagrant version and Vagrant API version
Vagrant.require_version ">= 2.0.0"
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # VMWare Support
  ["vmware_fusion", "vmware_workstation"].each do |provider|
    config.vm.provider provider do |v, override|
      v.vmx["memsize"] = "2048"
      v.vmx["numvcpus"] = "1"
      v.vmx["cpuid.coresPerSocket"] = "2"
    end
  end

  # Virtualbox Support
  config.vm.provider "virtualbox" do |v|
    v.memory = "2048"
    v.cpus = "2"
  end

  # Private Networking
  config.vm.network "private_network", type: "dhcp"

  # Set shared folders
  config.vm.synced_folder ".", "/vagrant"

  # Provisioning
  config.vm.define :secdev do |node|
    node.vm.box = "generic/arch"
    node.vm.hostname = "secdev"
    node.vm.provision :shell, path: "provision.sh", privileged: false
  end
end

