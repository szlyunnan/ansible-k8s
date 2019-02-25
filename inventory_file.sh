#!/usr/bin/env bash

AnsibleShell=${1:-"ansible-playbook"}
AnsibleForks=1
AnsibleInventory="inventory/init.ini"
AnsiblePlayBook="inventory_file.yaml"

${AnsibleShell} -i ${AnsibleInventory} ${AnsiblePlayBook} -f ${AnsibleForks}
