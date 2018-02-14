#!/bin/bash
set -ex

# Set up dependencies for and start running the LEIE API on a
# RHEL/CentOS server.

# gather requirements (note that you may need to add a separate repo to
# get the EPEL packages)
sudo yum install yum-utils
sudo yum -y groupinstall development
sudo yum install epel-release
sudo yum install python34 python34-pip virtualenv sqlite golang
sudo pip3.4 install --upgrade pip

# move from scripts dir to leie dir
cd ../etl

# set up goose
mkdir golang;
cd golang;
GOPATH=`pwd`;
export GOPATH; 
export PATH=$PATH:$GOPATH'/bin';

# create virtualenv and get packages from pip
cd ../leie
virtualenv --python=python3.4 .
source bin/activate
pip install -r requirements.txt


# run the LEIE API (this will leave it running in the background in this
# terminal)
cd leie
./model.py
./etl.py
./serve.py flask run &
