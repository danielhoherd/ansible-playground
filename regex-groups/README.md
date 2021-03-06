This shows how to use regex groups.

```
$ cat ./regex-groups.yml
---
- name: Show ways to use regex to create facts and replace textfile contents
  gather_facts: false
  hosts: localhost

  vars:
    db_connection: "postgresql://username:password@example.com:1234/some_db"

  tasks:
    - name: "parse regex"
      vars:
        regex: 'postgres(ql)?:\/\/(?P<username>[^:]+):(?P<password>[^@]+)@(?P<hostname>[^:]+):(?P<port>\d+)'
      set_fact:
        db_username: "{{ db_connection | regex_search(regex, '\\g<username>') | first }}"
        db_password: "{{ db_connection | regex_search(regex, '\\g<password>') | first }}"
        db_hostname: "{{ db_connection | regex_search(regex, '\\g<hostname>') | first }}"
        db_port: "{{ db_connection | regex_search(regex, '\\g<port>') | first }}"

    - debug:
        msg: "db_username: {{ db_username }}, db_password: {{ db_password }}, db_hostname: {{ db_hostname }}, db_port: {{ db_port }}"

    - name: "Show named backreferences using 'replace'"
      replace:
        path: example.txt
        regexp: "(?P<foo>foo).*(?P<bar>bar).*(?P<baz>baz)"
        replace: 'Replaced text: \g<baz> \g<bar> \g<foo>'

    - name: "Show  named capture groups using jinja2"
      debug:
        msg: "{{ 'localhost:80' | regex_replace('^(?P<host>.+):(?P<port>\\d+)$', 'hostname is \\g<host>, port number is \\g<port>') }}"
$ cat example.txt
foo bar baz
$ ansible-playbook -i localhost regex-groups.yml </dev/null 2>/dev/null

PLAY [Illustrate replaceing text with regex] ******************************************************************************************

TASK [parse regex] ********************************************************************************************************************
ok: [localhost]

TASK [debug] **************************************************************************************************************************
ok: [localhost] => {
    "msg": "db_username: username, db_password: password, db_hostname: example.com, db_port: 1234"
}

TASK [Show named backreferences using 'replace'] **************************************************************************************
changed: [localhost]

TASK [Show  named capture groups using jinja2] ****************************************************************************************
ok: [localhost] => {
    "msg": "hostname is localhost, port number is 80"
}

PLAY RECAP ****************************************************************************************************************************
localhost                  : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

$ cat example.txt
Replaced text: baz bar foo
```
