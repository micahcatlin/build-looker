FROM ubuntu:18.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --fix-missing -y \
  build-essential \
  bzip2 \
  chromium-browser \
  curl \
  git \
  gnupg \
  libfontconfig \
  locales \
  procps \
  python2.7 \
  ruby \
  sudo \
  tzdata \
  vim \
  wget

RUN useradd -ms /bin/bash -p $(openssl passwd looker) looker --groups sudo
WORKDIR /home/looker

# Install phantomjs in /opt, symlink it in /usr/local/bin where helltool expects it
ADD phantomjs-2.1.1-linux-x86_64.tar.bz2 /opt
RUN mkdir -p /usr/local/bin && ln -s /opt/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
RUN ["/bin/bash", "-c", "echo export PATH=/usr/local/bin:\\$PATH >> .bashrc"]

# Install java ,rvm, jruby and get them in to the default path
RUN ["/bin/bash", "-c", "curl https://storage.googleapis.com/micahc-backup/jdk-8u191-linux-x64.tar.bz2 \
|(mkdir -p /opt; cd /opt; tar jxf -)"]
RUN mkdir -p /usr/local/bin && ln -s /opt/jdk1.8.0_191/bin/java /usr/local/bin/java

# Make python2.7 be 'python' in the global path
RUN ["/bin/bash", "-c", "update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1"]

# Set default locale
RUN update-locale LANG=C.UTF-8

USER looker

COPY --chown=looker tmp/.ssh .ssh
COPY --chown=looker tmp/.gradle/gradle.properties .gradle/gradle.properties

# Install rvm, jruby, nvm and get them in to the default path
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import --no-tty
RUN ["/bin/bash", "-c", "set -o pipefail && curl -L https://get.rvm.io | bash -s stable --autolibs=3"]
RUN ["/bin/bash", "-c", "echo source /home/looker/.rvm/scripts/rvm >> .bashrc"]
RUN ["/bin/bash", "-c", "source /home/looker/.rvm/scripts/rvm && \
  rvm autolibs disable && \
  rvm install jruby-9.1.17.0 && \
  rvm use jruby-9.1.17.0 --default && \
  rvm gemset create looker && \
  rvm gemset use looker && \
  gem install bundler"]

RUN ["/bin/bash", "-c", "set -o pipefail && \
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash && \
  echo source /home/looker/.nvm/nvm.sh >> .bashrc"]
RUN ["/bin/bash", "-c", "source /home/looker/.nvm/nvm.sh && \
    nvm install 8.12.0 && \
    nvm use 8.12.0 && \
    nvm alias default 8.12.0"]

#TODO: Sort out a way to get the helltool.git checkout into the container as a volume that can
# be more flexibly composed.  For now, just rely on the user bind-mounting a checkout.
#RUN ["/bin/bash", "-c", "mkdir -p src/; cd src; git clone --progress --depth 1 git@github.com:looker/helltool.git"]

ENV JAVA_HOME /opt/jdk1.8.0_191
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

EXPOSE 9999
EXPOSE 19999

USER looker

ENTRYPOINT /bin/bash
