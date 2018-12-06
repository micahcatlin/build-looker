#Scripts to configure a Chromeos 'stretch' penguin container for Looker development with the necessary toolchain.
java, jruby(rvm), node(nvm), chromium, phantomjs, etc

### Pre-setup
Expected files:
  $HOME/.ssh/ contains keys for pulling from github
  $HOME/.gradle/gradle.properties is configured for pulling from Nexus
  $HOME/src/helltool is a checkout of helltool.git

### Setup
$ ./install.sh         # Make tea, this takes a while.
$ cd ~/src/helltool
$ bin/prepare
$ bin/helltool start

Docker is not necessary to build/run helltool, but it is needed to run integration tests.
This script installs the necessary binaries, but does not activate the dockerd service.
If you need to run integration tests, use another Terminal to run '$ sudo dockerd'

### 
The ChromeOS container has a special DNS alias in the .test TLD, penguin.linux.test.

https://penguin.linux.test:9999 should work in the OS browser.
