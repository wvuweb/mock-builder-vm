class Update < Vagrant.plugin(2, :command)

  def self.synopsis
    "updating mock_builder internals"
  end

  def execute

    command1 = "sudo kill -9 $(ps ax | grep '[m]ock_server.rb' | awk '{print $1}')"
    command2 = "cd /srv/mock_builder && sudo git pull"
    command3 = "cd /srv/mock_builder && sudo bundle install"
    command4 = "cd /srv/mock_builder/mock_builder && ruby mock_server.rb --daemon 1"

    with_target_vms(nil, :single_target => true) do |vm|
      safe_puts("Stopping Mock Builder Processes...")
      vm.action(:ssh_run, :ssh_run_command => command1, ssh_opts: {extra_args: ["-qT"]})
      safe_puts("Pulling latest code from GitHub...")
      vm.action(:ssh_run, :ssh_run_command => command2, ssh_opts: {extra_args: ["-qT"]})
      safe_puts("Running Bundle Install...")
      vm.action(:ssh_run, :ssh_run_command => command3, ssh_opts: {extra_args: ["-qT"]})
      safe_puts("Restarting Mock Builder...")
      vm.action(:ssh_run, :ssh_run_command => command4, ssh_opts: {extra_args: ["-qT"]})
      safe_puts("Finished Upgrade!")
      return 0
    end

  end
end
