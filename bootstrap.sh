# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential

install Ruby ruby1.9.3 ruby1.9.1-dev

echo installing Bundler
gem install bundler

install Git git

install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev
install 'ExecJS runtime' nodejs

git clone https://github.com/wvuweb/mock_builder.git /srv/mock_builder

cd /vagrant

gem install nokogiri -- --use-system-libraries=true --with-xml2-include=/usr/include/libxml2
gem install nokogumbo -- --use-system-libraries=true --with-xml2-include=/usr/include/libxml2

# check branch of mock_builder-vm if in dev switch hammer branch to dev
branch=$(git symbolic-ref --short HEAD)
cd /srv/mock_builder
if [ "$branch"="dev" ]; then
  echo "Checking out dev branch of Mock Builder"
  git checkout dev
fi

cd /srv/mock_builder
bundle install

# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8
