#!/bin/bash
# setup Jenkins on Amazon EC2
sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install java-1.8.0 -y
sudo yum install jenkins -y
sudo service jenkins start
#get initial password
sudo cat
/var/lib/jenkins/secrets/initialAdminPassword
