# Overview

Test whether disks that have the same content but in different order match.

# Demo

```yaml
---
# playbook.yml
# run with: ansible-playbook -i localhost playbook.yml </dev/null

- name: A local play
  hosts: localhost
  connection: local
  gather_facts: no

  vars:
    test_dict_1:
      foo: 'bar'
      fizz: 'buzz'

    test_dict_2:
      fizz: 'buzz'
      foo: 'bar'

    test_dict_1_as_json: '{"foo": "bar", "fizz": "buzz"}'

  tasks:
    - name: "Check equality"
      debug:
        msg: "{{ test_dict_1 }} is equal to {{ test_dict_2 }}"
      when: 'test_dict_1 == test_dict_2'
```

```
$ ansible-playbook -i localhost playbook.yml </dev/null 2>/dev/null

PLAY [A local play] ************************************************************

TASK [Check dict equality] *****************************************************
ok: [localhost] => {
    "msg": "{'foo': 'bar', 'fizz': 'buzz'} is equal to {'fizz': 'buzz', 'foo': 'bar'}"
}

TASK [Check dict and json equality] ********************************************
ok: [localhost] => {
    "msg": "{'foo': 'bar', 'fizz': 'buzz'} is equal to {'fizz': 'buzz', 'foo': 'bar'}"
}

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
