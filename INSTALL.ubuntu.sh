#!/bin/bash

#Compiler Dependencies:
sudo apt-get install build-essential libstdc++6 gfortran
#Python Dependencies:
sudo apt-get install python2.7 python-numpy python-scipy python-setuptools python-dev python-biopython
#Get Latest Release:
wget https://github.com/labxscut/grammy/archive/refs/tags/release.tar.gz
#Install:
tar -zxvf release.tar.gz
cd grammy-release
python setup.py install

