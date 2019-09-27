[![Build Status](https://cloud.drone.io/api/badges/dtf-ein/dev-laptop/status.svg)](https://cloud.drone.io/dtf-ein/dev-laptop)

# Developer laptops

Playbook for managing Ubuntu and Windows developer laptops using Ansible:

- Ubuntu uses local Ansible to configure, or can act as a control node for other hosts.
- Windows uses SSH and needs a Linux control node to configure it.

# Setup

Run the script for your OS:
```bash
# Ubuntu: install Ansible and dependencies
# This can now be a control node or just configure itself
./scripts/setup-debian.sh

# Windows: install OpenSSH and Ansible dependencies
./scripts/setup-windows.ps1
```
If you're on Ubuntu and planning to configure other hosts, you'll also need an [inventory file](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html).  This can be the default `/etc/ansible/hosts` file, or you can add it to this directory (like the `inv_localhost` inventory file).  Here's an example of how it could look for all the Windows hosts:

```bash
# filename: inv_windows
hostname1.url.com  ansible_user=username ansible_connection=ssh  ansible_shell_type=powershell
hostname2.url.com  ansible_user=username ansible_connection=ssh  ansible_shell_type=powershell
hostname3.url.com  ansible_user=username ansible_connection=ssh  ansible_shell_type=powershell

```

# Run the playbook

Install the playbook roles from Ansible Galaxy:

```bash
ansible-galaxy install -r ./requirements.yml
```

Run the playbook:

```bash
# Configure a new host, setting up public key authentication by passing the control node's id_rsa.pub file contents
# After running this, you won't need the --ask-pass arg anymore.
ansible-playbook play_developer.yml -i inventory_name --extra-vars="pubkey='ssh-rsa PUBKEY'" --ask-pass

# Configure a host that has public key auth already setup and run all playbooks
ansible-playbook play_all.yml -i inventory_name

# Configure a desktop only host that does not have public key auth (and you do not want to setup with public key auth).
ansible-playbook play_desktop.yml -i inventory_name --ask-pass
```

# Test the pipeline

Install the [Drone CLI](https://docs.drone.io/cli/install/) and run the following to test the pipeline:

```bash
drone exec --pipeline build .drone.yml
```


# Credit
Based on the [ESDC DevX laptop](https://github.com/esdc-devx/dev-laptop).

