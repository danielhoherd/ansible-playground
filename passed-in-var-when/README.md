Demonstration of how to pass in a variable and make decisions based on its presence.

```yaml
---
# playbook.yml
# run with: ansible-playbook -i localhost playbook.yml </dev/null

- name: A local play
  hosts: localhost
  connection: local

  tasks:
    - name: "TESTVAR is not set"
      when: TESTVAR is not defined
      debug:
        msg: "TESTVAR is not defined"

    - name: "TESTVAR is set"
      when: TESTVAR is defined
      debug:
        msg: "TESTVAR={{ TESTVAR }}"
```

```
$ ansible-playbook -i localhost playbook.yml </dev/null 2>/dev/null

PLAY [A local play] *************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************
ok: [localhost]

TASK [TESTVAR is not set] *******************************************************************************************
ok: [localhost] => {
    "msg": "TESTVAR is not defined"
}

TASK [TESTVAR is set] ***********************************************************************************************
skipping: [localhost]

PLAY RECAP **********************************************************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

$ ansible-playbook -e TESTVAR=true -i localhost playbook.yml </dev/null 2>/dev/null

PLAY [A local play] *************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************
ok: [localhost]

TASK [TESTVAR is not set] *******************************************************************************************
skipping: [localhost]

TASK [TESTVAR is set] ***********************************************************************************************
ok: [localhost] => {
    "msg": "TESTVAR=true"
}

PLAY RECAP **********************************************************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
```
