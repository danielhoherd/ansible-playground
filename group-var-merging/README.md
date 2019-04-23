# Description

This directory demonstrates an odd condition with ansible which is not a bug, and illustrates how inventory variables are resolved from all groups matched for an inventory host.

# Illustrating the problem

In inventory, we define two hosts:

```yaml
# inventory/inventory.yml
all:
  hosts:
    hosts:
      host-1:
      host-2:
```

We create a group that is used for accessing these two hosts under normal conditions:

```yaml
# inventory/inventory.yml
normal-group:
  hosts:
    host-1:
    host-2:
```

We create a group that is used for accessing these hosts under alternate conditions, in this case when they are only available via VPN:

```yaml
# inventory/inventory.yml
vpn-group:
  hosts:
    host-1:
    host-2:
```

We create a `group_vars` file for the normal conditions:
```yaml
# group_vars/normal-group.yml
ansible_ssh_common_args: 'normal-test-args'
```

We also create a `group_vars` file for the alternate VPN conditions:
```yaml
# group_vars/vpn-group.yml
ansible_ssh_common_args: 'normal-test-args'
```

However, when we run ansible against the `normal-group`, we see the `vpn-group`'s `group_vars` show up:

```shell
$ ansible-playbook --limit "normal-group" -i inventory/inventory.yml playbook.yml | grep -E 'inventory_hostname|vpn-test-args'
    "hostvars[inventory_hostname]": {
        "ansible_ssh_common_args": "vpn-test-args",
        "inventory_hostname": "host-1",
        "inventory_hostname_short": "host-1",
    "hostvars[inventory_hostname]": {
        "ansible_ssh_common_args": "vpn-test-args",
        "inventory_hostname": "host-2",
        "inventory_hostname_short": "host-2",
```

# What is actually happening

The problem here is that all groups for a given host are used to resolve variables for the host. This is described in <https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html#how-variables-are-merged>

> When groups of the same parent/child level are merged, it is done alphabetically, and the last group loaded overwrites the previous groups.

And a configurable option is available

> Starting in Ansible version 2.4, users can use the group variable ansible_group_priority to change the merge order for groups of the same level

So if we alter our inventory to be:

```yaml
normal-group:
  vars:
    ansible_group_priority: 10
  hosts:
    host-1:
    host-2:
```

Then when we run ansible, we get the `normal-group` value:

```shell
$ ansible-playbook --limit "normal-group" -i inventory/inventory.yml playbook.yml | grep -E 'inventory_hostname|test-args'
    "hostvars[inventory_hostname]": {
        "ansible_ssh_common_args": "normal-test-args",
        "inventory_hostname": "host-1",
        "inventory_hostname_short": "host-1",
    "hostvars[inventory_hostname]": {
        "ansible_ssh_common_args": "normal-test-args",
        "inventory_hostname": "host-2",
        "inventory_hostname_short": "host-2",
```

# An alternate solution

The above workaround using `ansible_group_priority` was actually unworkable for the circumstances that led me to discover this behavior, and we ended up going with a second inventory file that merges and overrides values defined in the primary inventory file. <https://danielhoherd.com/tech-notes/ansible/#merge-multiple-inventory-files>
