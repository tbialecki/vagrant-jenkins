# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
	config.vm.define 'jenkins' do |jenkins|
  		jenkins.vm.box = "ubuntu/trusty64"
  		jenkins.vm.hostname = 'jenkins'
  		jenkins.vm.provider :virtualbox do |vb|
      		vb.customize [
                       'modifyvm', :id,
                       '--name', 'jenkins',
                       '--memory', 2048,
                       '--ioapic', 'on'
                   ]
    		end
  		jenkins.vm.network :forwarded_port, guest: 80, host: 8082
  		jenkins.vm.provision "shell", path: "provision.sh"
  	end
end
