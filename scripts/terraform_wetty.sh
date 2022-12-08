#!/bin/bash

#dependencies
apt update && apt upgrade -y
apt install -y pip
apt install -y net-tools
apt install -y git
apt install -y nano
apt install -y default-jre

#create user
useradd -m -c "kodespace" -p "kodespace8667" -s /bin/bash 

#install terraform
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
apt update && apt install terraform
apt upgrade -y

#install wetty
apt install -y libncurses-dev flex libssl-dev libelf-dev bc bison
curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt-get install -y nodejs
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update && apt-get install -y yarn
yarn global add wetty

echo “export PATH=$PATH:/usr/local/bin” | tee -a /etc/profile
source /etc/profile
wetty --host 0.0.0.0 -p 3000
