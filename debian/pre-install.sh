#!/bin/sh

#upgrade the packages
apt-get update && apt-get upgrade -y

#install packages
apt-get install -y git lsb-release

#change the working directory
cd /usr/src/fusionpbx-install.sh/debian
