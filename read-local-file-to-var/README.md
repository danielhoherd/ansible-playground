This shows ways to load local files into a variable

```
$ cat playbook.yml
---
- name: A local play
  hosts: localhost
  connection: local
  gather_facts: yes
  vars:
    test_data: "{{ lookup('file', 'test.txt') }}"

  tasks:
    - name: Show file from vars
      debug:
        msg: "contents of test.txt are: {{ test_data }}"

    - name: Show file from tasks
      debug:
        msg: "Reading contets of file during tasks: {{ lookup('file', 'test.txt') }}"
```
```
$ ansible-playbook -i localhost playbook.yml 2>/dev/null </dev/null

PLAY [A local play] ************************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [Show file from vars] *****************************************************
ok: [localhost] => {
    "msg": "contents of test.txt are: Hello world"
}

TASK [Show file from tasks] ****************************************************
ok: [localhost] => {
    "msg": "Reading contets of file during tasks: Hello world"
}

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
