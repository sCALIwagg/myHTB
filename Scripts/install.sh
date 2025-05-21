#!/bin/bash

#   script to install a bunch of pentesting tools 
sudo apt install $(cat ../Tools/tools.list | tr "\n" " ") -y