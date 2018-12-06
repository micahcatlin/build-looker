#!/bin/bash

sudo apt-get update && DEBIAN_FRONTEND=noninteractive sudo apt-get install --fix-missing -y \
  build-essential \
  bzip2 \
  chromium \
  curl \
  git \
  gnupg2 \
  htop \
  libfontconfig \
  locales \
  procps \
  ruby \
  sudo \
  tzdata \
  vim \
  wget

# Install phantomjs in /opt, symlink it in /usr/local/bin where helltool expects it
if [ ! -e /usr/local/bin/phantomjs ]; then
  curl https://storage.googleapis.com/micahc-backup/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
  | (sudo bash -c "mkdir -p /opt; cd /opt; sudo tar jxf -")
  sudo bash -c " mkdir -p /usr/local/bin && ln -s /opt/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs"
fi


# Install java ,rvm, jruby and get them in to the default path
if [ ! -e /opt/jdk1.8.0_191 ]; then
  curl https://storage.googleapis.com/micahc-backup/jdk-8u191-linux-x64.tar.bz2 \
  | (sudo bash -c "mkdir -p /opt; cd /opt; sudo tar jxf -")

  sudo bash -c "echo JAVA_HOME=/opt/jdk1.8.0_191 > /etc/profile.d/java_home.sh"
  sudo bash -c "echo PATH=\\\$JAVA_HOME/bin:\\\$PATH >> /etc/profile.d/java_home.sh"
fi

# Install rvm, jruby
gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -L https://get.rvm.io | bash -s 1.29.3 --autolibs=3

source $HOME/.rvm/scripts/rvm
rvm reinstall jruby-9.1.17.0
rvm alias create default jruby-9.1.17.0
rvm gemset create looker
rvm gemset use looker
gem install bundler

# Install nvm and get them in to the default path
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash

source $HOME/.nvm/nvm.sh
nvm install 8.12.0
nvm use 8.12.0
nvm alias default v8.12.0

echo "Done.  Exit this Terminal and open a new one to pick up changes to .bashrc"
