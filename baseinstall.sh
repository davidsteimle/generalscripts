#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

# install lynx text browsers
sudo apt-get install lynx -y
# install Apache, mySQL, PHP as lamp-server
sudo apt-get install lamp-server^

# cleanup
sudo apt-get autoremove -y
