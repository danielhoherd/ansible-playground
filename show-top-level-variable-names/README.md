Demonstration of how to show all top-level variable names.

```yaml
---
# playbook.yml
# run with: ansible-playbook -i localhost playbook.yml </dev/null

- name: A local play
  hosts: localhost
  connection: local
  gather_facts: yes

  tasks:
    - name: Show all top level variable names
      debug:
        msg: "{{ lookup('varnames', '.+').split(',') | sort }}"
```

```sh
$ ansible-playbook -i localhost playbook.yml </dev/null 2>/dev/null
2019-10-16 11:39:11-0700

PLAY [A local play] ************************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [Show all top level variable names] ***************************************
ok: [localhost] => {
    "msg": [
        "ansible_all_ipv4_addresses",
        "ansible_all_ipv6_addresses",
        "ansible_apparmor",
        "ansible_architecture",
        "ansible_awdl0",
        "ansible_bridge0",
        "ansible_check_mode",
...snip...
        "ansible_virtualization_type",
        "ansible_XHC20",
        "environment",
        "gather_subset",
        "group_names",
        "groups",
        "hostvars",
        "inventory_hostname",
        "inventory_hostname_short",
        "module_setup",
        "omit",
        "play_hosts",
        "playbook_dir",
        "role_names",
        "vars"
    ]
}

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
