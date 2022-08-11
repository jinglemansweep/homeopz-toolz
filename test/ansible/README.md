## Provisioning

To provision a fresh device (VM, VPS etc.), you will need the IP address or hostname and a valid user with `sudo` privileges. You will also need to populate `provision.vars.yml` with the SSH public keys for the `automation` user. This user is created and provisioned with passwordless `sudo` access which the main playbooks use. The inventory (`-i`) parameter should be provided as a list, hence the trailing comma when specifying a single host.

    ansible-playbook playbooks/provision.yml \
      -i test.vps.example.com, \
      -u ubuntu \
      -e @provision.vars.yml \
      --ask-pass \
      --ask-become-pass