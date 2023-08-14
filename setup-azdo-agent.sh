#!/bin/sh

# sudo ./setup-azdo-agent.sh <agent pool name> <PAT> <AZDO url>

if [ -z "$1" ]; then
        echo "ERROR: Must pass the pool name as parameter 1"
        exit 1
fi

if [ -z "$2" ]; then
        echo "ERROR: Must pass the PAT as parameter 2"
        exit 1
fi

if [ -z "$3" ]; then
        echo "ERROR: Must AZDO url"
        exit 1
fi

if [ -d "./azdoagent" ]
then
    echo "FATAL: azdoAgent folder exists on your filesystem."
	exit 1
fi

su - vmadmin -c "
mkdir azdoagent && cd azdoagent
wget https://vstsagentpackage.azureedge.net/agent/2.214.1/vsts-agent-linux-x64-2.214.1.tar.gz
tar zxvf vsts-agent-linux-x64-2.214.1.tar.gz"

su - vmadmin -c "./bin/installdependencies.sh"

su - vmadmin -c "/home/vmadmin/azdoagent/config.sh --unattended --agent '${AZP_AGENT_NAME:-$(hostname)}' --url $3 --auth 'PAT' --token '$2' --replace --pool '$1'"


cd /home/vmadmin/azdoagent
sudo /home/vmadmin/azdoagent/svc.sh install vmadmin
sudo /home/vmadmin/azdoagent/svc.sh start

su - vmadmin -c "
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb"

sudo apt-get update && \
  sudo apt-get install -y curl apt-transport-https ca-certificates software-properties-common git wget && \
  sudo apt-get install -y dotnet-sdk-3.1 && \
  sudo apt-get install -y dotnet-sdk-6.0 && \
  sudo apt-get install -y dotnet-sdk-7.0

sudo apt update && \
  sudo apt upgrade -y

sudo apt-get install -y nodejs npm

# install Azure CLI - Begins
sudo apt-get update
sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg

sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg


AZ_REPO=$(lsb_release -cs)
echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-get update
sudo apt-get install azure-cli

# install docker
# https://docs.docker.com/engine/install/ubuntu/

sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo apt-get update
sudo chmod 666 /var/run/docker.sock
sudo systemctl restart docker


# install PowerShell
sudo apt-get install -y powershell
# Start PowerShell
pwsh
