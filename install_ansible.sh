#!/usr/bin/env bash

ansible_repo="https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/ansible-2.6.2-1.el7.ans.noarch.rpm"

function _download_install_repo() {
  yum -y install wget
  wget -O /tmp/ansible-2.6.2.repo.rpm ${ansible_repo}
  yum -y localinstall /tmp/ansible-2.6.2.repo.rpm
  yum makecache
}

function _install_ansible() {
  yum -y install ansible
}

_download_install_repo
_install_ansible
