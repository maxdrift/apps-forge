VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box_check_update = false

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.include_offline = true

  config.ssh.forward_agent = true

  config.user.defaults = {
    db: {
      folders: [],
      ports: [],
      networks: {
        private: [
          ip_address: '192.168.100.10'
        ]
      },
      cpus: 1,
      memory: 512
    },
    ruby: {
      folders: [],
      ports: [],
      networks: {
        private: [
          ip_address: '192.168.100.20'
        ]
      },
      cpus: 1,
      memory: 1024
    }
  }

  boxes = {
    db:   'ubuntu/trusty32',
    ruby: 'ubuntu/trusty32'
  }

  config.user.each do |node_id, node_config|
    config.vm.define node_id do |node|
      node.vm.box = boxes[node_id]

      node_config.ports.each do |item|
        node.vm.network :forwarded_port, guest: item[:guest], host: item[:host]
      end

      node_config.networks.private.each do |item|
        node.vm.network :private_network, ip: item[:ip_address]
      end

      node_config.folders.each do |item|
        node.vm.synced_folder item[:host], item[:guest]
      end

      node.vm.provider :virtualbox do |vb|
        vb.name = "#{node_id}-devbox"
        vb.cpus = node_config.cpus
        vb.memory = node_config.memory
      end

      node.vm.hostname = "#{node_id}-devbox.local"

      node.vm.provision :ansible do |ansible|
        ansible.playbook = "provisioning/#{node_id}.yml"
      end
    end
  end

  config.vm.provision :hostmanager

  config.trigger.before :provision, stdout: true do
    info 'Installing Ansible Roles'

    run 'provisioning/./install-roles.sh'
  end
end