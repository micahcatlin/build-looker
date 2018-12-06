#Scripts to configure a Debian 'stretch' system for Looker development with the necessary toolchain.
java, jruby(rvm), node(nvm), chromium, phantomjs, etc

### Pre-setup
Expected files:
```
  ~/.ssh/ contains keys for pulling from github
  ~/.gradle/gradle.properties is configured for pulling from Nexus

  ~/src/helltool is a checkout of helltool.git
```

### Setup
```bash
$ ./install.sh         # Make tea, this takes a while.
$ exit                 # ~/.bashrc modified for nvm/rvm shell functions
```

```bash
$ cd ~/src/helltool
$ bin/prepare
$ bin/helltool start
```

### ChromeOS considerations
The ChromeOS container has a special DNS alias in the .test TLD, penguin.linux.test.

https://penguin.linux.test:9999 should work in the OS browser


Docker is not necessary to build/run helltool, but it is needed to run integration tests.
This script installs the necessary binaries, but does not activate the dockerd service.
If you need to run integration tests, use another Terminal to run 

```
$ cd docker-chromeos
$ ./docker-chromeos  # Adds Docker APT source, does post-patching for chromeos
$ sudo dockerd
```

## Tips for developing on Pixelbook

Sublime Text 3 works pretty well, but needs a settings adjustment for the high DPI screen (otherwise the tab labels are in a tiny font)

From http://tipsonubuntu.com/2017/05/30/install-sublime-text-3-ubuntu-16-04-official-way/

```bash
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

```

After launching `subl`, Use Preferences -> Settings and add 

```json
{
  "dpi_scale": 2.0
}
```

Special setup for xterm, and other X11 apps.
```bash
cat << EOF >> ~/.sommelierrc
# The default font face that xterm selects is not part of the
# penguin 'stretch' image, so override with one that is.  Also choose large size.
echo "XTerm.*.faceName: Cousine:size=16:antialias=false" | xrdb -merge
echo Xft.dpi: 192 | xrdb -merge

# from https://chromium.googlesource.com/chromiumos/platform2/+/413a646b5b7067a989bab2ef9fca0c3a4515cc22/vm_tools/sommelier/README.md
# Contents Scaling
# Contents scaling can be applied to both native wayland clients and X11 clients.
# It can be controlled using the --scale=SCALE flag or SOMMELIER_SCALE=SCALE
# variable. Where SCALE is a display density multiplier. For example, if the
# default density is 200 DPI, then using --scale=0.5 will result in contents
# produced for 100 DPI.
export SOMMELIER_SCALE=0.5
EOF
```
