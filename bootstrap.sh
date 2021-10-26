#!/bin/sh

if ! command -v ansible > /dev/null ; then
    if ! command -v pip3 > /dev/null ; then
        package_manager=$(command -v apt-get || command -v dnf || command -v yum)
        sudo "${package_manager}" install -y python3-pip
    fi
    pip3 install ansible
fi

# install ansible galaxy components
ansible-galaxy collection install -r requirements.yml

sudo sed -ibackup 's/^#\(stdout_callback = \).*/\1yaml/' /etc/ansible/ansible.cfg

echo "You are now ready to run playbooks in this repository."
