This shows how to use regex groups.

```
$ bat example.txt ; ansible-playbook -i localhost regex-groups.yml 2>/dev/null < /dev/null ; bat example.txt ;
───────┬────────────────────────────────────────────────────────────────────────
       │ File: example.txt
───────┼────────────────────────────────────────────────────────────────────────
   1   │ foo bar baz
───────┴────────────────────────────────────────────────────────────────────────

PLAY [Illustrate replaceing text with regex] ***********************************

TASK [Show named backreferences] ***********************************************
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=1    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

───────┬────────────────────────────────────────────────────────────────────────
       │ File: example.txt
───────┼────────────────────────────────────────────────────────────────────────
   1   │ Replaced text: baz bar foo
───────┴────────────────────────────────────────────────────────────────────────
```
