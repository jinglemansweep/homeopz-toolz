# HomeOpz Tools

[![Docker Build](https://github.com/jinglemansweep/homeopz-toolz/actions/workflows/docker.build.yml/badge.svg)](https://github.com/jinglemansweep/homeopz-toolz/actions/workflows/docker.build.yml)

HomeOpz Toolkit (Toolz) as a Docker container

    docker run -it --rm -v $(readlink -f ${SSH_AUTH_SOCK}):/run/ssh-agent -e SSH_AUTH_SOCK=/run/ssh-agent -v ${PWD}/work:/data:ro ghcr.io/jinglemansweep/homeopz-toolz:main bash