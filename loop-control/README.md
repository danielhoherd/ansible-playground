This shows some examples of `loop_control`

- <https://docs.ansible.com/ansible/latest/user_guide/playbooks_loops.html#adding-controls-to-loops>

```
$ cat playbook.yml
---
# playbook.yml
# run with: ansible-playbook -i localhost playbook.yml

- name: A local play
  hosts: localhost
  connection: local
  gather_facts: yes
  vars:
    demo_vars:
      - name: foo
        some_numbers:
          - 0
          - 1
          - 42
      - name: bar
        some_numbers:
          - 2
          - 3
          - 255

  tasks:
    - name: show stuff
      debug:
        var: "{{ item.some_numbers }}"
      loop: "{{ demo_vars }}"
      loop_control:
        label: "This is demo label '{{ item.name }}' on loop index {{ loop_index }}"
        index_var: loop_index
        pause: 1
$ ansible-playbook -i localhost playbook.yml 2>/dev/null </dev/null

PLAY [A local play] ************************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [show stuff] **************************************************************
ok: [localhost] => (item=This is demo label 'foo' on loop index 0) => {
    "<class 'list'>": "VARIABLE IS NOT DEFINED!",
    "ansible_loop_var": "item",
    "item": {
        "name": "foo",
        "some_numbers": [
            0,
            1,
            42
        ]
    },
    "loop_index": 0
}
ok: [localhost] => (item=This is demo label 'bar' on loop index 1) => {
    "<class 'list'>": "VARIABLE IS NOT DEFINED!",
    "ansible_loop_var": "item",
    "item": {
        "name": "bar",
        "some_numbers": [
            2,
            3,
            255
        ]
    },
    "loop_index": 1
}

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
