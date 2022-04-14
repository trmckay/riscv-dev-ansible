#!/bin/bash

set -e
savedir=$(pwd)

if command -v apt-get > /dev/null; then
    apt-get install ansible
elif command -v dnf > /dev/null; then
    dnf install ansible
fi

tmp=$(mktemp -d)
cd "$tmp"

git clone https://github.com/trmckay/riscv-dev-ansible
cd riscv-dev-ansible

ansible-playbook -K --connection=localhost riscv-dev.yml || echo -e "\nInstall failed!"

rm -rf "$tmp"
cd "$savedir"
