#!/bin/bash

#   script to install a bunch of pentesting tools 
sudo apt install $(cat tools.txt | tr "\n" " ") -y