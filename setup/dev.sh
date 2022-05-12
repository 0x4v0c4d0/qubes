# Update
sudo apt-get update

# Install Doker
# According to https://docs.docker.com/engine/install/debian/

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y
    
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
 
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose -y

# Execute docker post installation step
# https://docs.docker.com/engine/install/linux-postinstall/
sudo groupadd docker
sudo usermod -aG docker $USER

# Install NodeJs
curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
sudo apt-get install nodejs -y

# Install VSCode
sudo apt install software-properties-common apt-transport-https curl -y

curl -sSL https://packages.microsoft.com/keys/microsoft.asc -o microsoft.asc
gpg --no-default-keyring --keyring ./ms_signing_key_temp.gpg --import ./microsoft.asc
gpg --no-default-keyring --keyring ./ms_signing_key_temp.gpg --export > ./ms_signing_key.gpg
sudo mv ms_signing_key.gpg /etc/apt/trusted.gpg.d/

echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

sudo apt update
sudo apt install code -y

# Install virtualbox
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian bullseye contrib" |
    sudo tee /etc/apt/sources.list.d/virtualbox.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo apt update && sudo apt install virtualbox -y


# Install rsync
sudo apt-get install rsync -y
