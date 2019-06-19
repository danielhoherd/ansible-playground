# Illustrate changed_when with loops

```
$ cat playbook.yml
---
- name: Illustrate changed_when with loops
  gather_facts: false
  hosts: localhost
  vars:
    things:
      - foo
      - bar

  tasks:
    - debug:
        msg: "{{ item }}"
      loop: "{{ things }}"

    - debug:
        msg: "{{ item }}"
      loop: "{{ things }}"
      changed_when: item != "bar"
$ ansible-playbook -i localhost playbook.yml 2>/dev/null </dev/null

PLAY [Illustrate changed_when with loops] **************************************

TASK [debug] *******************************************************************
ok: [localhost] => (item=foo) => {
    "msg": "foo"
}
ok: [localhost] => (item=bar) => {
    "msg": "bar"
}

TASK [debug] *******************************************************************
ok: [localhost] => (item=foo) => {
    "msg": "foo"
}
ok: [localhost] => (item=bar) => {
    "msg": "bar"
}

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
