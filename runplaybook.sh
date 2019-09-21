#!/bin/sh
echo "entering"

if [ "$(id -u)" -ne 0 ]; then
        echo 'This script must be run by root' >&2
        exit 1
fi

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
force=0
skipansible=0
echo "getopts"
while getopts "fes" opt; do
    case "$opt" in
    f) force=1
        ;;
    s) skipansible=1
        ;;
    **) ;;
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift
echo "skipansible ${skipansible}"
if [ $skipansible = 0 ]; then
  echo "running ansible"
  if [ $force = 1 ]; then
    echo "forcing requirements"
    ansible-galaxy install -r ./requirements.yml --force
  else
    echo "installing requirements"
    ansible-galaxy install -r ./requirements.yml
  fi

  ansible-playbook playbook.yml --connection=local

fi
