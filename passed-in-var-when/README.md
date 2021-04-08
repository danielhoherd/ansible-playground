Demonstration of how to pass in a variable and make decisions based on its value.

```yaml
---
# playbook.yml
# run with: ansible-playbook -i localhost playbook.yml </dev/null

- name: A local play
  hosts: localhost
  connection: local
  gather_facts: yes

  tasks:
    - name: "TESTVAR is not defined"
      when: TESTVAR is not defined
      debug:
        msg: "TESTVAR is not defined"

    - name: "TESTVAR is defined"
      when: TESTVAR is defined
      debug:
        msg: "TESTVAR={{ TESTVAR }}"

    - name: "TESTVAR is not defined or is false"
      when: (TESTVAR is not defined) or not (TESTVAR | bool)
      debug:
        msg: "TESTVAR is not defined or is false"

    - name: "TESTVAR is True"
      when: (TESTVAR is defined) and (TESTVAR | bool)
      debug:
        msg: "TESTVAR={{ TESTVAR }}"

    - name: "TESTVAR is not True"
      when: (TESTVAR is defined) and not ( TESTVAR | bool)
      debug:
        msg: "TESTVAR={{ TESTVAR }}"

    - name: "TESTVAR is squee"
      when: (TESTVAR is defined) and (TESTVAR == "squee")
      debug:
        msg: "TESTVAR={{ TESTVAR }}"
```

```
$ ./show-behaviors.sh
+ ansible-playbook -i localhost playbook.yml

PLAY [A local play] **********************************************************************************************

TASK [Gathering Facts] *******************************************************************************************
ok: [localhost]

TASK [TESTVAR is not defined] ************************************************************************************
ok: [localhost] => {
    "msg": "TESTVAR is not defined"
}

TASK [TESTVAR is defined] ****************************************************************************************
skipping: [localhost]

TASK [TESTVAR is not defined or is false] ************************************************************************
ok: [localhost] => {
    "msg": "TESTVAR is not defined or is false"
}

TASK [TESTVAR is True] *******************************************************************************************
skipping: [localhost]

TASK [TESTVAR is not True] ***************************************************************************************
skipping: [localhost]

TASK [TESTVAR is squee] ******************************************************************************************
skipping: [localhost]

PLAY RECAP *******************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

+ ansible-playbook -e TESTVAR=0 -i localhost playbook.yml

PLAY [A local play] **********************************************************************************************

TASK [Gathering Facts] *******************************************************************************************
ok: [localhost]

TASK [TESTVAR is not defined] ************************************************************************************
skipping: [localhost]

TASK [TESTVAR is defined] ****************************************************************************************
ok: [localhost] => {
    "msg": "TESTVAR=0"
}

TASK [TESTVAR is not defined or is false] ************************************************************************
ok: [localhost] => {
    "msg": "TESTVAR is not defined or is false"
}

TASK [TESTVAR is True] *******************************************************************************************
skipping: [localhost]

TASK [TESTVAR is not True] ***************************************************************************************
ok: [localhost] => {
    "msg": "TESTVAR=0"
}

TASK [TESTVAR is squee] ******************************************************************************************
skipping: [localhost]

PLAY RECAP *******************************************************************************************************
localhost                  : ok=4    changed=0    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0

+ ansible-playbook -e TESTVAR=1 -i localhost playbook.yml

PLAY [A local play] **********************************************************************************************

TASK [Gathering Facts] *******************************************************************************************
ok: [localhost]

TASK [TESTVAR is not defined] ************************************************************************************
skipping: [localhost]

TASK [TESTVAR is defined] ****************************************************************************************
ok: [localhost] => {
    "msg": "TESTVAR=1"
}

TASK [TESTVAR is not defined or is false] ************************************************************************
skipping: [localhost]

TASK [TESTVAR is True] *******************************************************************************************
ok: [localhost] => {
    "msg": "TESTVAR=1"
}

TASK [TESTVAR is not True] ***************************************************************************************
skipping: [localhost]

TASK [TESTVAR is squee] ******************************************************************************************
skipping: [localhost]

PLAY RECAP *******************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

+ ansible-playbook -e TESTVAR=squee -i localhost playbook.yml

PLAY [A local play] **********************************************************************************************

TASK [Gathering Facts] *******************************************************************************************
ok: [localhost]

TASK [TESTVAR is not defined] ************************************************************************************
skipping: [localhost]

TASK [TESTVAR is defined] ****************************************************************************************
ok: [localhost] => {
    "msg": "TESTVAR=squee"
}

TASK [TESTVAR is not defined or is false] ************************************************************************
ok: [localhost] => {
    "msg": "TESTVAR is not defined or is false"
}

TASK [TESTVAR is True] *******************************************************************************************
skipping: [localhost]

TASK [TESTVAR is not True] ***************************************************************************************
ok: [localhost] => {
    "msg": "TESTVAR=squee"
}

TASK [TESTVAR is squee] ******************************************************************************************
ok: [localhost] => {
    "msg": "TESTVAR=squee"
}

PLAY RECAP *******************************************************************************************************
localhost                  : ok=5    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
```
