# -*- mode: ruby -*-
# vi: set ft=ruby :


# https://github.com/hashicorp/vagrant/issues/1874#issuecomment-165904024
# not using 'vagrant-vbguest' vagrant plugin because now using bento images which has vbguestadditions preinstalled.
def ensure_plugins(plugins)
  logger = Vagrant::UI::Colored.new
  result = false
  plugins.each do |p|
    pm = Vagrant::Plugin::Manager.new(
      Vagrant::Plugin::Manager.user_plugins_file
    )
    plugin_hash = pm.installed_plugins
    next if plugin_hash.has_key?(p)
    result = true
    logger.warn("Installing plugin #{p}")
    pm.install_plugin(p)
  end
  if result
    logger.warn('Re-run vagrant up now that plugins are installed')
    exit
  end
end

required_plugins = ['vagrant-hosts', 'vagrant-share', 'vagrant-vbox-snapshot', 'vagrant-host-shell', 'vagrant-reload']
ensure_plugins required_plugins



Vagrant.configure(2) do |config|
  config.vm.define "consul_server" do |consul_server|
    consul_server.vm.box = "bento/centos-7.6"
    consul_server.vm.hostname = "consul-server.example.com"
    # https://www.vagrantup.com/docs/virtualbox/networking.html
    consul_server.vm.network "private_network", ip: "10.2.5.110", :netmask => "255.255.255.0", virtualbox__intnet: "intnet2"

    consul_server.vm.network "forwarded_port", guest: 8500, host: 8500, protocol: 'tcp'


    consul_server.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.memory = "1024"
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
      vb.name = "centos7_consul_server"
    end

    consul_server.vm.provision "ansible" do |ansible|
      ansible.extra_vars = {
        vm_role: "consul_server"
      }
      ansible.playbook = "setup-consul.yml"
    end


  end


  config.vm.define "consul_agent" do |consul_agent|
    consul_agent.vm.box = "bento/centos-7.6"
    consul_agent.vm.hostname = "consul-agent.example.com"
    consul_agent.vm.network "private_network", ip: "10.0.2.16"
    consul_agent.vm.network "private_network", ip: "10.2.5.111", :netmask => "255.255.255.0", virtualbox__intnet: "intnet2"

    consul_agent.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.memory = "1024"
      vb.cpus = 2
      vb.name = "centos7_consul_agent"
    end

    consul_agent.vm.provision "ansible" do |ansible|
      ansible.extra_vars = {
        vm_role: "webserver"
      }
      ansible.playbook = "setup-consul.yml"
    end

  end

  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '10.2.5.110', ['consul-server.example.com']
    provisioner.add_host '10.2.5.111', ['consul-agent.example.com']
  end

end