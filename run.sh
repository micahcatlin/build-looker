# Start a container from looker-build with interactive shell
docker run \
  -v $HOME/src:/home/looker/src \
  -v $HOME/.ssh:/home/looker/.ssh \
  -v $HOME/.gradle:/home/looker/.gradle \
  -it looker-build
