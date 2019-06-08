This shows how to set vars based off of the OS distro. These vars can then be used to include files, fill in templates, etc..


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
    Ubuntu:
      foo: "This is the Ubuntu.foo value"
      bar: "This is the Ubuntu.bar value"
    MacOSX:
      foo: "This is the MacOSX.foo value"
      bar: "This is the MacOSX.bar value"


  tasks:
    - name: show stuff
      debug:
        var: "{{ ansible_distribution }}"

$ ansible-playbook -i localhost playbook.yml 2>/dev/null </dev/null

PLAY [A local play] ************************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [show stuff] **************************************************************
ok: [localhost] => {
    "MacOSX": {
        "bar": "This is the MacOSX.bar value",
        "foo": "This is the MacOSX.foo value"
    }
}

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0
```
