# KodeSpace
Final Project

# Purpose

Streaming containerized apps and desktops to end-users. The Workspaces platform provides enterprise-class orchestration, 
data loss prevention, and web streaming technology to enable the delivery of containerized workloads to your browser.


















# Creating the docker image for jenkins
create an ubuntu image as the base of the container

and execute this commands

apt update
apt -y install openjdk-11-jre
apt install -y curl

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

apt update
apt -y install jenkins
apt -y install systemctl 

systemctl start jenkins
systemctl enable jenkins

to verify that is working systemctl status jenkins


