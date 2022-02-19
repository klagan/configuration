#!/bin/bash

# e.g. ./script --param value
check=${check:-true}

while [ $# -gt 0 ]; do
   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
        # echo $1 $2 # to see the parameter:value result
   fi
  shift
done

# if [ "$a" = "true" ]; then <do something>; fi 

# if  [ "$a" = "false" ] && 
#     [ "$b" = "false" ] &&
#     [ "$c" =  "false" ]; 
# then echo <do something>; fi

sudo apt update
sudo apt install git
sudo apt install python3-pip
# sudo apt install ansible
pip install ansible-core
pip install ansible
sudo ansible-galaxy install -r requirements.yml
sudo ansible-galaxy install -r roles/requirements.yml
if [ "$check" = "false" ]; then sudo ansible-playbook devbox.yml -u root; echo "(not checked)"; else sudo ansible-playbook devbox.yml -u root --check; echo "checked"; fi 

echo "Script complete (check = $check)"

