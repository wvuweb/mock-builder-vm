require 'optparse'

module MockBuilder
  class Root < Vagrant.plugin("2", :command)
    def self.synopsis
      "commands specific to mock-builder"
    end

    def initialize(argv, env)
      super

      @main_args, @sub_command, @sub_args = split_main_and_subcommand(argv)
      @subcommands = Vagrant::Registry.new

      @subcommands.register(:update) do
        require_relative "update"
        Update
      end
    end

    def execute
      if @main_args.include?("-h") || @main_args.include?("--help")
        # Print the help for all the sub-commands.
        return help
      end

      # If we reached this far then we must have a subcommand. If not,
      # then we also just print the help and exit.
      command_class = @subcommands.get(@sub_command.to_sym) if @sub_command
      return help if !command_class || !@sub_command
      @logger.debug("Invoking command class: #{command_class} #{@sub_args.inspect}")

      # Initialize and execute the command class
      command_class.new(@sub_args, @env).execute
    end

    # Prints the help out for this command
    def help
      opts = OptionParser.new do |o|
        o.banner = "Usage: vagrant mock-builder <command> [<args>]"
        o.separator ""
        o.separator "Available subcommands:"

        # Add the available subcommands as separators in order to print them
        # out as well.
        keys = []
        @subcommands.each { |key, value| keys << key.to_s }

        keys.sort.each do |key|
          o.separator "     #{key}"
        end

        o.separator ""
        o.separator "For help on any individual command run `vagrant mock-builder COMMAND -h`"
      end

      @env.ui.info(opts.help, :prefix => false)
    end

  end
end
