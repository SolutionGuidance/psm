#!/bin/bash

# Switch to ansible dir
cd `dirname $0`/../ansible

# Run script that invokes ansible role 'psm' on localhost
sudo ./run localhost.yml psm
