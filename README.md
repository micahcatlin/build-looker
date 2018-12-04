#Scripts to configure a Dockerized build environment with:
 java, jruby(rvm), node(nvm), chromium, phantomjs, etc

### Pre-setup
If you're running in the 'penguin' Terminal container on ChromeOS, run this
script to get a working "docker" binary

```
  $ cd docker-chromeos/
  $ sh docker-chromeos.sh
```

Expected files:
  $HOME/.ssh/ contains keys for pulling from github
  $HOME/.gradle/gradle.properties is configure for pulling from Nexus
  $HOME/src/helltool is a checkout of helltool.git

### Setup
$ sh build.sh  # Build a container in the local docker environment
$ sh run.sh    # Launch a shell in that container, ready for "bundle install && bin/helltool start"

### TODO
Networking is not quite right -- If you run a helltool server in the Terminal container,
it will be reachable on https://172.17.0.2:9999 from within the container, but not from
the host OS.  This can surely be improved.
