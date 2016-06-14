# -*- mode: ruby -*-
# vi: set ft=ruby 

# Load custom configuration in Vagrantfile.local
custom_vagrantfile = 'Vagrantfile.local'
load custom_vagrantfile if File.exist?(custom_vagrantfile)

Vagrant.configure(2) do |config|
  config.vm.define "local" do |local| 
    local.vm.box = "debian/jessie64"
    local.vm.network "private_network", type: "dhcp"
    local.vm.network "forwarded_port", guest: 80, host: 8080
    local.vm.provider "virtualbox" do |v|
      v.memory = 2048
    end
    local.vm.synced_folder "docker", "/srv/docker", type: "rsync",
                            rsync__args: ["--verbose", "--archive", "--delete", "-z"],
                            rsync__chown: false, disabled: true

    local.vm.synced_folder ".", "/vagrant", disabled: true
    local.vm.synced_folder "formulas", "/srv/provision/formulas"
    local.vm.synced_folder "pillar", "/srv/provision/pillar"
    local.vm.synced_folder "salt", "/srv/provision/salt"

    local.vm.provision :salt do |salt|
      # salt.bootstrap_script = "../salt-bootstrap/bootstrap-salt.sh"
      # salt.bootstrap_options = "-d"
      # salt.install_type = "git"
      salt.masterless = true
      salt.minion_config = "salt/minion"
      salt.run_highstate = false
      salt.colorize = true
      salt.verbose = true
      salt.log_level = "warning" 
    end
  end
end
