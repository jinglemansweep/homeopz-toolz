# HomeOpz Toolz

[![Docker Build](https://github.com/jinglemansweep/homeopz-toolz/actions/workflows/docker.build.yml/badge.svg)](https://github.com/jinglemansweep/homeopz-toolz/actions/workflows/docker.build.yml)

HomeOpz Toolkit (Toolz) as a Docker container

## Shell Usage

The Toolz container is designed to be used interactively. The following example will mount the current directory into the containers work area (`/work`) and open an interactive `bash` shell:

    docker run -it --rm -v ${PWD}:/work:ro ghcr.io/jinglemansweep/homeopz-toolz:main bash

This next example will also mount and activate your existing SSH agent, allowing for usage of tools such as `git` inside the Toolz container:

    docker run -it --rm -v $(readlink -f ${SSH_AUTH_SOCK}):/run/ssh-agent -e SSH_AUTH_SOCK=/run/ssh-agent -v ${PWD}:/work:ro ghcr.io/jinglemansweep/homeopz-toolz:main bash

Depending on your requirements, add the relevant command to your shell aliases, remembering to add to `.bashrc` or equivalent. Also note that you shouldn't specify the final command (e.g. `bash`) as this can be passed using the alias (e.g. `toolz bash` or `toolz ansible-playbook`):

    alias toolz="docker run -it --rm -v $(readlink -f ${SSH_AUTH_SOCK}):/run/ssh-agent -e SSH_AUTH_SOCK=/run/ssh-agent -v ${PWD}:/work:ro ghcr.io/jinglemansweep/homeopz-toolz:main"

### Ansible

Toolz ships with the latest stable pre-configured Ansible setup. Common and useful Ansible roles and collections have been bundled within the Toolz container.

#### Provisioning

To provision a fresh device (VM, VPS etc.), you will need the IP address or hostname and a valid user with `sudo` privileges. You will also need to populate `provision.vars.yml` with the SSH public keys for the `automation` user. This user is created and provisioned with passwordless `sudo` access which the main playbooks use. The inventory (`-i`) parameter should be provided as a list, hence the trailing comma when specifying a single host.

    toolz ansible-playbook ./playbooks/provision.yml \
      -i test-ansible.home.ptre.es, \
      -u ubuntu --ask-pass --ask-become-pass \
      -e @./provision.vars.yml 
