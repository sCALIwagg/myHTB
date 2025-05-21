#!/bin/bash

#   This program will append some parrot repos to the sources list of your distro

declare -i distro=0

echo "Hello, friend!"

echo "What distro are you using? (more will be added later)"
read -p "1=Ubuntu, 2=Debian: (int pls)" distro

