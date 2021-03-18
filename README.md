# Configuration scripting

Attempt to capture my common configuration tasks and make my personal machines more easily replaceable.

## Usage

Run `./bootstrap.sh` to install Python3 pip and Ansible.
This *should* work on Debian-derived and Red Hat-derived systems using the apt package manager or yum/dnf package managers.

Run `ansible-playbook -K --connection=local -i 127.0.0.1, development.yml`

## Requirements

Requires ansible and the `community.general` collection from ansible galaxy.
