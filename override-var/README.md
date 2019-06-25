This demonstrates two ways to select an alternate variable, one by overwriting the default and two by using `default` jinja filter to pick an alternative to a variable to use.

- <https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html#defaulting-undefined-variables>

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
    - include_tasks: "more_tasks.yml"

    - set_fact:
        inventory_hostname: "overridden.inventory.hostname.example.com"

    - include_tasks: "more_tasks.yml"

    - set_fact:
        custom_hostname: "custom.hostname.example.com"

    - include_tasks: "more_tasks.yml"
$ cat more_tasks.yml
---
- name: show hostname stuff
  debug:
    msg: "hostname to use is: {{ custom_hostname | default(inventory_hostname) }}"
$ ansible-playbook -i localhost playbook.yml 2> /dev/null < /dev/null

PLAY [A local play] ************************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [include_tasks] ***********************************************************
included: /Users/daniel.hoherd/code/ansible-playground/override-var/more_tasks.yml for localhost

TASK [show hostname stuff] *****************************************************
ok: [localhost] => {
    "msg": "hostname to use is: localhost"
}

TASK [set_fact] ****************************************************************
ok: [localhost]

TASK [include_tasks] ***********************************************************
included: /Users/daniel.hoherd/code/ansible-playground/override-var/more_tasks.yml for localhost

TASK [show hostname stuff] *****************************************************
ok: [localhost] => {
    "msg": "hostname to use is: overridden.inventory.hostname.example.com"
}

TASK [set_fact] ****************************************************************
ok: [localhost]

TASK [include_tasks] ***********************************************************
included: /Users/daniel.hoherd/code/ansible-playground/override-var/more_tasks.yml for localhost

TASK [show hostname stuff] *****************************************************
ok: [localhost] => {
    "msg": "hostname to use is: custom.hostname.example.com"
}

PLAY RECAP *********************************************************************
localhost                  : ok=9    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
