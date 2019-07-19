# ho-ansible/tinc
Ansible role to configure tinc VPN

## Multiple networks
+ Include this role multiple times
+ See [sample playbook](https://github.com/ho-ansible/ansible/blob/master/plays/tinc.yml)

## Role variables
Network names may only have the characters `[a-zA-Z0-9_]+` (no hyphens).

### Network config
+ `tinc_subnet_`*<network>* (e.g., `192.168.2`): the first 3 quads of a /24 (for now)
  + This is mandatory
+ `tinc_mode_`*<network>*: `switch` or `router`
+ `tinc_domain_`*<network>* (e.g., `mynet.vpn`): DNS domain name of VPN (can be internal)
+ `tinc_dns_`*<network>* (e.g., `192.168.2.1`): IP of DNS server on VPN

### Host config
+ `tinc_port_`*<network>* (e.g., `655`): port to listen on
+ `tinc_ip_`*<network>* (e.g., `192.168.2.10`): static IP 
+ `tinc_name_`*<network>* (e.g., `myhost`): name in tinc, if different from `inventory_hostname`
+ `tinc_addresses_`*<network>* (e.g., `[10.0.0.1]`): list of Address lines for other nodes to connect
+ `tinc_subnets_`*<network>* (e.g., `[192.168.2.0/24]`): list of Subnet lines for routing

### Inventory Groups
+ `tinc_nodes_`*<network>*: all nodes in the given network
+ `tinc_servers_`*<network>*: just the servers (hosts to Connect to)

### Misc
+ `tinc_keystore`: dir to store RSA/ED25519 keys

# Author
Ansible role by Sean Ho
