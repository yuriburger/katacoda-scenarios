echo "Setup Azure Functions package feed"
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

echo "Setup Terraform repository"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

echo "Install Azure CLI"
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

echo "Install Terraform and Azure Functions CLI"
sudo apt-get update
sudo apt-get install terraform azure-functions-core-tools-3
