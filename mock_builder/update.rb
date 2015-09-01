require 'optparse'

module MockBuilder
  class Update < Vagrant.plugin(2, :command)

    def self.synopsis
      "updating mock_builder internals"
    end

    def initialize(argv, env)
      super

      @main_args, @sub_command, @sub_args = split_main_and_subcommand(argv)
    end

    def execute

      if @main_args.include?("-h") || @main_args.include?("--help")
        # Print the help for all the sub-commands.
        return help
      end

      command1 = "sudo kill -9 $(ps ax | grep '[m]ock_server.rb' | awk '{print $1}')"
      command2 = "cd /srv/mock_builder && sudo git pull"
      command3 = "cd /srv/mock_builder && sudo bundle install"
      command4 = "cd /srv/mock_builder/mock_builder && ruby mock_server.rb --daemon 0"

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

    def help
      help = OptionParser.new do |h|
        h.banner = "Usage: vagrant mock-builder update"
        h.separator ""
        h.separator "    # VM must be running"
        h.separator "    # #{Update.synopsis}"
        h.separator ""
        h.separator "Running this command will stop the Mock Builder server"
        h.separator "and pull the latest code from GitHub.  Then restart"
        h.separator "the Mock Builder server."
      end

      @env.ui.info(help, :prefix => false)
    end
  end
end
