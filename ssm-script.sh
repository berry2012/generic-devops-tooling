#!/bin/bash

#This script allows you to automatically install AWS SSM on your hybrid environment.
#Be sure to enter your activation code and ID. 

banner()
{
  echo "+-----------------------------------------------------------+"
  printf "| %-40s |\n" "`date`"
  echo "|                                                           |"
  printf "|`tput bold` %-40s `tput sgr0`|\n" "$@"
  echo "+-----------------------------------------------------------+"
}
banner "Starting installation of AWS SSM on Hybrid Environment"
sleep 3

mkdir /tmp/ssm
cd /tmp/ssm
wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
sleep 2
sudo dpkg -i amazon-ssm-agent.deb
sudo systemctl status amazon-ssm-agent | grep inactive
if [ $? = 0 ];
then
	sudo systemctl enable amazon-ssm-agent
fi
banner "Activate with AWS Account"
sudo service amazon-ssm-agent stop
sudo amazon-ssm-agent -register -code "activation-code" -id "activation-id" -region "region" 
sudo service amazon-ssm-agent start
banner "AWS SSM Installation Completed!"
