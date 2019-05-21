This shows how to split a list in half and run two tasks, one with each half.

```
$ ansible-playbook -i localhost two-tasks-one-list.yml 2>/dev/null < /dev/null

PLAY [Illustrate iterating one list with two different tasks] ******************

TASK [debug] *******************************************************************
ok: [localhost] =>
  msg: 'First half: [''sda'', ''sdb'', ''sdc'']'

TASK [debug] *******************************************************************
ok: [localhost] =>
  msg: 'Second half: [''sdd'', ''sde'', ''sdf'']'

TASK [debug] *******************************************************************
ok: [localhost] => (item=0) =>
  msg: task 1 disk 0 is sda
ok: [localhost] => (item=1) =>
  msg: task 1 disk 1 is sdb
ok: [localhost] => (item=2) =>
  msg: task 1 disk 2 is sdc

TASK [debug] *******************************************************************
ok: [localhost] => (item=3) =>
  msg: task 2 disk 3 is sdd
ok: [localhost] => (item=4) =>
  msg: task 2 disk 4 is sde
ok: [localhost] => (item=5) =>
  msg: task 2 disk 5 is sdf

PLAY RECAP *********************************************************************
localhost                  : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
