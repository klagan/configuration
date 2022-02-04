
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
sudo apt install ansible
pip install ansible-core
sudo ansible-galaxy install -r requirements.yml
if [ "$check" = "false" ]; then sudo ansible-playbook devbox.yml; echo "(not checked)"; else sudo ansible-playbook devbox.yml --check; echo "checked"; fi 

echo "Script complete (check = $check)"

