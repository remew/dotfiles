# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provider :virtualbox do |vbox|
      vbox.name = "vm-name"
  end

  config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "private_network", ip: "192.168.56.100"

  config.vm.synced_folder ".", "/.synced"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y language-pack-ja
    sed -i 's/en_US/ja_JP/g' /etc/default/locale
  SHELL
end
