This shows some of the diferent behaviors of querying data with `query` vs `lookup`.

- <https://docs.ansible.com/ansible/latest/plugins/lookup.html#invoking-lookup-plugins-with-query>

```yaml
---
# playbook.yml
# run with: ansible-playbook -i localhost playbook.yml

- name: A local play
  hosts: localhost
  connection: local
  gather_facts: yes
  vars:
    a_list:
      - "item one"
      - "item two"
      - "item three"
    a_dict:
      one: 1
      two: 2
      three: 3

  tasks:
    # Show with list
    - name: "use bare vars['a_list']"
      debug:
        msg: "here is a result: {{ vars['a_list'] }}"

    - name: "use 'lookup' wantlist=False"
      debug:
        msg: "here is a result: {{ lookup('vars', 'a_list') }}"

    - name: "use 'lookup' wantlist=True"
      debug:
        msg: "here is a result: {{ lookup('vars', 'a_list', wantlist=True) }}"

    - name: "use 'query'"
      debug:
        msg: "here is a result: {{ query('vars', 'a_list') }}"

    # Show with dict
    - name: "use bare vars['a_dict']"
      debug:
        msg: "here is a result: {{ vars['a_dict'] }}"

    - name: "use 'lookup' wantlist=False"
      debug:
        msg: "here is a result: {{ lookup('vars', 'a_dict') }}"

    - name: "use 'lookup' wantlist=True"
      debug:
        msg: "here is a result: {{ lookup('vars', 'a_dict', wantlist=True) }}"

    - name: "use 'query'"
      debug:
        msg: "here is a result: {{ query('vars', 'a_dict') }}"
```

```
$ ansible-playbook -i localhost playbook.yml 2>/dev/null </dev/null

PLAY [A local play] ************************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [use bare vars['a_list']] *************************************************
ok: [localhost] => {
    "msg": "here is a result: ['item one', 'item two', 'item three']"
}

TASK [use 'lookup' wantlist=False] ********************************************
ok: [localhost] => {
    "msg": "here is a result: ['item one', 'item two', 'item three']"
}

TASK [use 'lookup' wantlist=True] *********************************************
ok: [localhost] => {
    "msg": "here is a result: [['item one', 'item two', 'item three']]"
}

TASK [use 'query'] *************************************************************
ok: [localhost] => {
    "msg": "here is a result: [['item one', 'item two', 'item three']]"
}

TASK [use bare vars['a_dict']] *************************************************
ok: [localhost] => {
    "msg": "here is a result: {'one': 1, 'two': 2, 'three': 3}"
}

TASK [use 'lookup' wantlist=False] ********************************************
ok: [localhost] => {
    "msg": "here is a result: {'one': 1, 'two': 2, 'three': 3}"
}

TASK [use 'lookup' wantlist=True] *********************************************
ok: [localhost] => {
    "msg": "here is a result: [{'one': 1, 'two': 2, 'three': 3}]"
}

TASK [use 'query'] *************************************************************
ok: [localhost] => {
    "msg": "here is a result: [{'one': 1, 'two': 2, 'three': 3}]"
}

PLAY RECAP *********************************************************************
localhost                  : ok=9    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
