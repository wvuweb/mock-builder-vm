# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.7.2"

# Check for plugin
unless Vagrant.has_plugin?("vagrant-triggers")
  raise 'vagrant-triggers is not installed!'
end


Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/trusty32'
  config.vm.hostname = 'mock-builder-vm'

  config.vm.network :forwarded_port, guest: 2000, host: 2000

  config.vm.synced_folder "../slate_themes", "/srv/slate_themes"

  config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true

  config.trigger.after [:up], stdout: true, stderr: true do
    info "Starting Mock Builder..."
    run_remote "cd /srv/mock_builder/mock_builder && ruby mock_server.rb --daemon 1"
  end

  config.trigger.before [:halt], stdout: true, stderr: true do
    info "Stopping Mock Builder..."
    run_remote "sudo kill -9 $(ps ax | grep '[m]ock_server.rb' | awk '{print $1}')"
  end
end
