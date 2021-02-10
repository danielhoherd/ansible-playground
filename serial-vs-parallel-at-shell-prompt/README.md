This shows how to control serial vs parallel on the shell prompt.

```
$ cat inventory.yml
---
all:
  hosts:
    hosts:
      foo:
      bar:
      s1:
      s2:

serial:
  hosts:
    s1:
    s2:

parallel:
  hosts:
    foo:
    bar:
$ cat serial-test.yml
---
- name: Test serial vs parallel
  gather_facts: false
  serial: "{{ serial | default(10) | int }}"
  hosts: all
  pre_tasks:
    - debug:
        var: serial

$ ansible-playbook -e serial=1 --limit "serial" -i inventory.yml serial-test.yml
 [WARNING]: Found variable using reserved name: serial


PLAY [Test serial vs parallel] *************************************************

TASK [debug] *******************************************************************
ok: [s1] => {
    "serial": "1"
}

PLAY [Test serial vs parallel] *************************************************

TASK [debug] *******************************************************************
ok: [s2] => {
    "serial": "1"
}

PLAY RECAP *********************************************************************
s1                         : ok=1    changed=0    unreachable=0    failed=0
s2                         : ok=1    changed=0    unreachable=0    failed=0

$ ansible-playbook -e serial=10 --limit "parallel" -i inventory.yml serial-test.yml
 [WARNING]: Found variable using reserved name: serial


PLAY [Test serial vs parallel] *************************************************

TASK [debug] *******************************************************************
ok: [foo] => {
    "serial": "10"
}
ok: [bar] => {
    "serial": "10"
}

PLAY RECAP *********************************************************************
bar                        : ok=1    changed=0    unreachable=0    failed=0
foo                        : ok=1    changed=0    unreachable=0    failed=0
```

You can see by how the output is grouped when it was run in parallel vs when it was run in serial. Unfortunately it doesn't look like you can put that var in inventory and have it do anything, but the `default(10)` is respected, which you can test by setting it to 1 in the playbook.
