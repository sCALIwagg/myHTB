#!/bin/bash

#   script to install a bunch of pentesting tools 
sudo apt install $(cat tools.list | tr "\n" " ") -y