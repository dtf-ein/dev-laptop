#!  /bin/bash

#Setup a dev laptop for Docker and Terraform development

apt update
apt install software-properties-common -y
apt-add-repository --yes --update ppa:ansible/ansible
DEBIAN_FRONTEND=noninteractive apt install ansible ansible-lint -y