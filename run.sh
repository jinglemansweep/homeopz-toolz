#!/bin/bash

declare -r image="ghcr.io/jinglemansweep/homeopz-toolz:main"
declare -r work_dir="${1:-${PWD}}"
shift 1

docker run \
  -it --rm \
  -v $(readlink -f ${SSH_AUTH_SOCK}):/run/ssh-agent \
  -v ${work_dir}:/data:rw \
  -e SSH_AUTH_SOCK=/run/ssh-agent \
  ${image} \
  $*

