This shows ways to load local files into a variable

```
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

    - name: Interpolate scary file contents
      shell: |
        echo -n "{{ lookup('file', 'scary-contents.txt') }}"
      register: scary_contents

    - name: Show that scary contents did bad things
      debug:
        var: "scary_contents.stdout_lines"
```

```
# cat scary-contents.txt
--------| backticks:
`find /var/ -maxdepth 1`
--------| variable subshell:
$(find /etc/ -maxdepth 1)
```

```
# ansible-playbook -i localhost playbook.yml </dev/null 2>/dev/null

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

TASK [Interpolate scary file contents] *****************************************
changed: [localhost]

TASK [Show that scary contents did bad things] *********************************
ok: [localhost] => {
    "scary_contents.stdout_lines": [
        "--------| backticks:",
        "/var/",
        "/var/local",
        "/var/tmp",
        "/var/lib",
        "/var/run",
        "/var/log",
        "/var/spool",
        "/var/cache",
        "/var/backups",
        "/var/opt",
        "/var/lock",
        "/var/mail",
        "--------| variable subshell:",
        "/etc/",
        "/etc/rc4.d",
        "/etc/pam.d",
        "/etc/host.conf",
        "/etc/subuid",
        "/etc/rc2.d",
        "/etc/libaudit.conf",
        "/etc/cron.daily",
        "/etc/nsswitch.conf",
        "/etc/alternatives",
        "/etc/shadow",
        "/etc/rc0.d",
        "/etc/login.defs",
        "/etc/terminfo",
        "/etc/hostname",
        "/etc/systemd",
        "/etc/sysctl.d",
        "/etc/bindresvport.blacklist",
        "/etc/rmt",
        "/etc/ld.so.conf",
        "/etc/rc6.d",
        "/etc/init.d",
        "/etc/ld.so.cache",
        "/etc/debian_version",
        "/etc/group",
        "/etc/profile.d",
        "/etc/apt",
        "/etc/update-motd.d",
        "/etc/default",
        "/etc/rc5.d",
        "/etc/ld.so.conf.d",
        "/etc/adduser.conf",
        "/etc/machine-id",
        "/etc/gai.conf",
        "/etc/.pwd.lock",
        "/etc/debconf.conf",
        "/etc/security",
        "/etc/selinux",
        "/etc/gshadow",
        "/etc/rc1.d",
        "/etc/rcS.d",
        "/etc/passwd",
        "/etc/networks",
        "/etc/rc3.d",
        "/etc/hosts",
        "/etc/resolv.conf",
        "/etc/shells",
        "/etc/profile",
        "/etc/opt",
        "/etc/bash.bashrc",
        "/etc/lsb-release",
        "/etc/kernel",
        "/etc/issue.net",
        "/etc/sysctl.conf",
        "/etc/securetty",
        "/etc/deluser.conf",
        "/etc/skel",
        "/etc/dpkg",
        "/etc/environment",
        "/etc/subgid",
        "/etc/legal",
        "/etc/logrotate.d",
        "/etc/pam.conf",
        "/etc/issue",
        "/etc/fstab",
        "/etc/mke2fs.conf",
        "/etc/os-release",
        "/etc/mtab",
        "/etc/locale.gen",
        "/etc/ca-certificates",
        "/etc/network",
        "/etc/xdg",
        "/etc/magic.mime",
        "/etc/wgetrc",
        "/etc/ssl",
        "/etc/services",
        "/etc/gss",
        "/etc/X11",
        "/etc/mime.types",
        "/etc/ssh",
        "/etc/dbus-1",
        "/etc/protocols",
        "/etc/mailcap.order",
        "/etc/shadow-",
        "/etc/bash_completion.d",
        "/etc/perl",
        "/etc/vim",
        "/etc/logcheck",
        "/etc/python",
        "/etc/python3.6",
        "/etc/passwd-",
        "/etc/python2.7",
        "/etc/group-",
        "/etc/locale.alias",
        "/etc/python3",
        "/etc/ca-certificates.conf",
        "/etc/magic",
        "/etc/inputrc",
        "/etc/gshadow-",
        "/etc/mailcap",
        "/etc/ldap",
        "/etc/rpc"
    ]
}

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
