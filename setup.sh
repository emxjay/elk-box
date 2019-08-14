#!/usr/bin/env bash

# Install Java 8.
sudo apt-get install apt-transport-https
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
sudo apt-get update
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get -y install oracle-java8-installer oracle-java8-set-default

# Setup packages' source.
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
sudo apt-get update

# Install ELK.
sudo apt-get -y install elasticsearch logstash kibana

# Run the whole stack.
sudo /etc/init.d/elasticsearch start
sudo systemctl logstash start
sudo /etc/init.d/kibana start

# Make sure the stack runs on start-up.
sudo systemctl enable elasticsearch
sudo systemctl enable logstash
sudo systemctl enable kibana
sudo systemctl daemon-reload
