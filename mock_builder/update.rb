class Update < Vagrant.plugin(2, :command)

  def self.synopsis
    "updating mock_builder internals"
  end

  def execute
    puts "Updating Mock Builder..."
    `vagrant ssh -c "sudo kill -9 $(ps ax | grep '[m]ock_server.rb' | awk '{print $1}') && cd /srv/mock_builder && sudo git pull && bundle install && cd mock_builder && ruby mock_server.rb --daemon 1" default`
    puts "Mock Builder updated!"
  end
end
