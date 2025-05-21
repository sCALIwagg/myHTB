#!/bin/bash

#   script to install a bunch of pentesting tools 
#   (requires parrot source lists)
sudo apt install $(cat ../Tools/tools.txt | tr "\n" " ") -y