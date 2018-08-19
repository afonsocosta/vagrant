#!/bin/sh
set -e -x

if which puppet > /dev/null ; then
	echo "Puppet is already installed"
	exit 0
fi


echo "Adding puppet repo"
sudo apt-get update
echo "installing puppet"
sudo apt-get -y install puppetmaster
sudo apt-get -y install puppet

echo "ensure puppet service is running"
sudo puppet resource service puppet ensure=running enable=true
#echo "ensure puppet service is running"
#sudo puppet resource service puppetmaster ensure=running enable=true

echo "ensure puppet service is running for standalone install"
sudo puppet resource cron puppet-apply ensure=present user=root minute=30 command='/usr/bin/puppet apply $(puppet apply --configprint manifest)'

