#!/bin/bash

set -e
savedir=$(pwd)

if command -v apt-get > /dev/null; then
    sudo apt-get update
    sudo apt-get install -y ansible git
elif command -v dnf > /dev/null; then
    sudo dnf install -y ansible git
fi

tmp=$(mktemp -d)
cd "$tmp"

git clone https://git.trmckay.com/tm/riscv-dev-ansible
cd riscv-dev-ansible

root_pass="$(read -s -p 'Enter password for sudo: ')"

ansible-playbook \
    --extra-vars "ansible_sudo_pass=$root_pass" \
    --connection=localhost riscv-dev.yml || \
    echo -e "\nInstall failed!"

rm -rf "$tmp"
cd "$savedir"
