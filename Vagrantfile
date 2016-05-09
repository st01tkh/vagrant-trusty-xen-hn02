# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.hostname = "trusty-xen-hn02"
  config.vm.box = "ubuntu/trusty64"
  #config.puppet_install.puppet_version = :latest
  #
  #config.librarian_puppet.puppetfile_dir = "."
  # placeholder_filename defaults to .PLACEHOLDER
  #config.librarian_puppet.placeholder_filename = ".MYPLACEHOLDER"
  #config.librarian_puppet.use_v1_api  = '1' # Check https://github.com/rodjek/librarian-puppet#how-to-use
  #config.librarian_puppet.destructive = false # Check https://github.com/rodjek/librarian-puppet#how-to-use
  #
  #config.vm.network "public_network", :mac => "080028348ae1", :bridge => "Marvell Yukon 88E8056 PCI-E Gigabit Ethernet Controller"
  #
  config.vbguest.auto_update = true
  #
  #config.vm.network "public_network", :mac => "08002c5338be", :bridge => "Realtek PCIe GBE Family Controller"
  config.vm.network "public_network", :mac => "080027988cd9", :bridge => [
  #config.vm.network "public_network", :bridge => [
    "Realtek PCIe GBE Family Controller",
    "Realtek RTL8139/810x Family Fast Ethernet NIC #2"
  ]
  #
  #config.vm.network "public_network", :mac => "0800284d4d1c", :bridge => "Marvell Yukon 88E8056 PCI-E Gigabit Ethernet Controller"
  # config.vm.network "public_network"
  #config.vm.network "private_network", type: "dhcp"
  #config.vm.synced_folder ".", "/vagrant", type: "nfs"
  #
  #config.winnfsd.uid = 1
  #config.winnfsd.gid = 1
  #
  ##
  #
  #config.vm.provision :host_shell do |host_shell|
  #	host_shell.inline = "mkdir TEST"
  #end
  #
  ##
  #config.trigger.before :up, :option => "value", :append_to_path => "" do
  #config.trigger.before :up,
#	  :append_to_path => File.expand_path(File.dirname(__FILE__)) do
#    run "before_up.sh"
#  end
  #
  #config.hostmanager.enabled = true
  #config.hostmanager.manage_host = true
  #config.hostmanager.ignore_private_ip = false
  #config.hostmanager.include_offline = true
  #config.vm.define 'p112-vm01' do |node|
  #  node.vm.hostname = 'p112-vm01'
    #node.vm.network :private_network, ip: '192.168.42.42'
  #  node.hostmanager.aliases = %w(p112-vm01.localdomain p112-vm01.kh.talex-id.net)
  #end
  #
  config.vm.provider "virtualbox" do |vb|
     # Display the VirtualBox GUI when booting the machine
     #vb.gui = true
     vb.memory = "2048"
     vb.customize [
	     "modifyvm", :id,
	     "--paravirtprovider", "kvm",
	     #"--cpus", "1"
     ]
  end
  #
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL
  #
  #config.persistent_storage.enabled = true
  #config.persistent_storage.location = "i:\\Users\\Public\\VM\\virt-disks\\p112-stor01.vmdk"
  #config.persistent_storage.size = 18000 
  #config.persistent_storage.mountname = 'stor01'
  #config.persistent_storage.filesystem = 'ext4'
  #config.persistent_storage.mountpoint = '/stor01'
  #config.persistent_storage.volgroupname = 'myvolgroup'
  config.vm.provision "shell", path: "import_modules.trusty.sh"
  config.vm.provision "puppet" do |puppet|
    #logging = ENV['LOGGING']
    #puppet.options << "--#{logging}" if ["verbose","debug"].include?(logging)
    puppet.module_path = ["modules", "modules-contrib", "modules-local"]
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "site.pp"
  end
end
