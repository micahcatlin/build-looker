# Start a container from looker-build with interactive shell
docker run \
  -v $HOME/.ssh:/home/looker/.ssh \
  -v $HOME/.gradle:/home/looker/.gradle \
  -v $HOME/src:/home/looker/src \
  -it looker-build \
  start
