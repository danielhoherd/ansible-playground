#!/usr/bin/env bash

set -x

ansible-playbook -i localhost playbook.yml 2>/dev/null

ansible-playbook -e TESTVAR=0 -i localhost playbook.yml 2>/dev/null

ansible-playbook -e TESTVAR=1 -i localhost playbook.yml 2>/dev/null

ansible-playbook -e TESTVAR=squee -i localhost playbook.yml 2>/dev/null
