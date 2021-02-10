The ansible `when` statement can be quite frustrating when matching against strings that contain special characters. You have to get your quotes and escapes just right.

- <https://docs.ansible.com/ansible/latest/user_guide/playbooks_conditionals.html#the-when-statement>

```
$ cat playbook.yml
---
# playbook.yml
# run with: ansible-playbook -i localhost playbook.yml

- name: A local play
  hosts: localhost
  connection: local
  gather_facts: yes

  tasks:
    - shell: |
        echo 'Enabled: Yes'
      register: cmd

    - name: "Show cmd.stdout"
      debug:
        msg: "cmd.stdout is: {{ cmd.stdout }}"

    - name: "Show cmd.stdout.find() result"
      debug:
        msg: "cmd.stdout.find('Enabled: Yes') is: {{ cmd.stdout.find('Enabled: Yes') }}"

    - name: "Check cmd.stdout using 'in' syntax"
      debug:
        msg: "cmd.stdout has 'Enabled: Yes': {{ cmd.stdout }}"
      when: '"Enabled: Yes" in cmd.stdout'

    - name: "Check cmd.stdout using 'not in' syntax"
      debug:
        msg: "cmd.stdout does not have 'Enabled: Yes': {{ cmd.stdout }}"
      when: '"Enabled: Yes" not in cmd.stdout'

    - name: "Check cmd.stdout using find() syntax"
      debug:
        msg: "cmd.stdout has 'Enabled: Yes': {{ cmd.stdout }}"
      when: 'cmd.stdout.find("Enabled: Yes") != -1'

    - name: "Check cmd.stdout using find() syntax"
      debug:
        msg: "cmd.stdout does not have 'Enabled: Yes': {{ cmd.stdout }}"
      when: 'cmd.stdout.find("Enabled: Yes") == -1'
```

```
$ ansible-playbook -i localhost playbook.yml 2>/dev/null </dev/null

PLAY [A local play] ************************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [shell] *******************************************************************
changed: [localhost]

TASK [Show cmd.stdout] *********************************************************
ok: [localhost] => {
    "msg": "cmd.stdout is: Enabled: Yes"
}

TASK [Show cmd.stdout.find() result] *******************************************
ok: [localhost] => {
    "msg": "cmd.stdout.find('Enabled: Yes') is: 0"
}

TASK [Check cmd.stdout using 'in' syntax] **************************************
ok: [localhost] => {
    "msg": "cmd.stdout has 'Enabled: Yes': Enabled: Yes"
}

TASK [Check cmd.stdout using 'not in' syntax] **********************************
skipping: [localhost]

TASK [Check cmd.stdout using find() syntax] ************************************
ok: [localhost] => {
    "msg": "cmd.stdout has 'Enabled: Yes': Enabled: Yes"
}

TASK [Check cmd.stdout using find() syntax] ************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=6    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
```
