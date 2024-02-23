#!/usr/bin/env sh

set -e

dev_image=${DEV_IMAGE:-"ns8-dnsmasq-dev:18.19.1"}
container_name=ns8-dnsmasq-dev

build_image() {
    podman build \
        --force-rm \
        --layers \
        --target "$1" \
        --tag "$2" \
        .
}

if [ "$1" = "build" ]; then
    build_image "dev" "$dev_image"
    exit 0
fi

if ! podman image exists "$dev_image"; then
    build_image "dev" "$dev_image"
fi

# params given will be appended at the end of the command
commands_given="$*"
shift "$#"

# setup podman command
set -- "$@" podman

if podman container exists $container_name; then
  # base command to execute in container
  set -- "$@" exec
  # if terminal is interactive, add interactive and tty flags
  if [ -t 0 ]; then
    set -- "$@" --interactive --tty
  fi
  # add container name
  set -- "$@" $container_name
else
  # base command to create container
  set -- "$@" run --name $container_name --replace --rm --volume "$(pwd)/ui":/app:Z
  # if terminal is interactive, add interactive and tty flags
  if [ -t 0 ]; then
    set -- "$@" --interactive --tty
  fi
  # check if port 5173 is already in use, if not, add publish flag
  if lsof -Pi :5173 -sTCP:LISTEN -t >/dev/null; then
      echo "Something is listening on port 5173, you won't be able to reach dev build."
  else
      set -- "$@" --publish 5173:5173
  fi
  # add image name
  set -- "$@" "$dev_image"
fi

# if commands_given are not zero, append them
if [ -n "$commands_given" ]; then
  for command in $commands_given; do
    set -- "$@" "$command"
  done
fi

"$@"
