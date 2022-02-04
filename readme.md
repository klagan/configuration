# Pre-requisites

- sudo apt update
- sudo apt install git
- sudo apt install ansible
- sudo ansible-galaxy collection install -r requirements.yml
- sudo ansible-playbook devbox.yml --check


## Recommendations

### Alternative to `curl`

TASK [Install Terraform] ************************************************************************************************************************************************************************************************************
[WARNING]: Consider using the get_url or uri module rather than running 'curl'.  If you need to use command because get_url or uri is insufficient you can add 'warn: false' to this command task or set 'command_warnings=False' in
ansible.cfg to get rid of this message.

### VS Code issues rendering

```
sudo vi /usr/share/applications/code.desktop

# change execution entry to:
Exec=/usr/share/code/code --disable-gpu --unity-launch %F
```
