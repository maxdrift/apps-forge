VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box_check_update = false

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.include_offline = true

  config.ssh.forward_agent = true

  config.user.defaults = {
    db: {
      debug: false,
      folders: [],
      ports: [],
      networks: {
        private: [
          ip_address: '192.168.100.100'
        ]
      },
      cpus: 1,
      memory: 512
    },
    ruby: {
      debug: false,
      folders: [],
      ports: [],
      networks: {
        private: [
          ip_address: '192.168.100.101'
        ]
      },
      cpus: 1,
      memory: 512
    },
    js: {
      debug: false,
      folders: [],
      ports: [],
      networks: {
        private: [
          ip_address: '192.168.100.102'
        ]
      },
      cpus: 1,
      memory: 512
    }
  }

  boxes = {
    db:   'ubuntu/trusty32',
    js:   'ubuntu/trusty32',
    ruby: 'ubuntu/trusty32'
  }

  config.vm.provision :hostmanager

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
        vb.name = node_id.to_s
        vb.cpus = node_config.cpus
        vb.memory = node_config.memory
      end

      node.vm.hostname = node_id.to_s

      node.vm.provision :ansible_local do |ansible|
        ansible.galaxy_role_file = 'provisioning/RoleFile'
        ansible.galaxy_roles_path = 'provisioning/roles'
        ansible.install = true
        ansible.limit = node_id
        ansible.playbook = 'provisioning/playbook.yml'
        ansible.verbose  = 'vvvv' if node_config.debug == true
      end
    end
  end
end
