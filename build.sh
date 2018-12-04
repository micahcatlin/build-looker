#curl -O https://storage.googleapis.com/micahc-backup/jdk-8u191-linux-x64.tar.bz2

mkdir -p container-build-context/tmp/.gradle
cp -R ~/.ssh container-build-context/tmp
cp ~/.gradle/gradle.properties container-build-context/tmp/.gradle
docker build -t looker-build container-build-context  # Use Dockerfile in this directory to make an image
rm -rf container-build-context/tmp
