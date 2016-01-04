#!/usr/bin/env bash

#############################################################
# Install Java8
#############################################################
if which java >/dev/null; then
   	echo "skip java 8 installation"
else
	echo "java 8 installation"
	apt-get install --yes python-software-properties
	add-apt-repository ppa:webupd8team/java
	apt-get update -qq
	echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
	echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections
	apt-get install --yes oracle-java8-installer
	yes "" | apt-get -f install
fi

#############################################################
# Install Jenkins
#############################################################
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update
apt-get -y install jenkins

#############################################################
# Install nginx
#############################################################
apt-get -y install nginx

if [ -e /etc/nginx/sites-available/default ]; then
	rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
fi

if [ ! -e /etc/nginx/sites-available/jenkins.nginx ]; then
	ln -s /vagrant/config/jenkins.nginx /etc/nginx/sites-available/jenkins.nginx
	cd /etc/nginx/sites-enabled 
	ln -s ../sites-available/jenkins.nginx
fi
service nginx restart

#############################################################
# Install Jenkins plugins
#############################################################
java -jar /vagrant/config/jenkins-cli.jar -s http://localhost:8080/ wait-node-online
java -jar /vagrant/config/jenkins-cli.jar -s http://localhost:8080/ install-plugin htmlpublisher git
service jenkins restart

#############################################################
# Install Jenkins plugins
#############################################################
apt-get -y install docker.io


