# ho-ansible/tinc
Ansible role to configure tinc VPN

## Global variables
+ `tinc_networks`: list of names
+ Per-network configuration is in 
  `{{ inventory_dir }}/.tinc/networks/{{ tinc_name }}.yml`

## Role variables
+ `tinc_mode`: switch or router
+ `tinc_domain`: 
+ `tinc_ip`: static IP (optional)
+ `tinc_hostname`: name in tinc, if different from `inventory_hostname`

## Playbook for all networks
```
- name: tinc VPN
  hosts: all
  tasks:
    - include_tasks: tasks/tinc-role.yml
      with_items: "{{ tinc_networks }}"
      loop_control:
        loop_var: tinc_name
```

Task `tinc-role.yml`:
```
- name: "tinc {{ tinc_name }} | vars"
  include_vars: "{{ inventory_dir }}/.tinc/networks/{{ tinc_name }}.yml"

- name: "tinc {{ tinc_name }} | role"
  include_role:
    name: tinc
```
