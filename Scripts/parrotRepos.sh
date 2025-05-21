#!/bin/bash

#   This program will append some parrot repos to the sources list of your distro

declare -i distro=0

echo "Hello, friend!"

echo "What distro are you using? (more will be added later)"
read -p "1=Ubuntu, 2=Debian: (int pls)" distro

if [$distro -eq 1];
then
    echo "You're using Ubuntu"
elif [$distro -z || $distro -eq 0];
then
    echo "Please enter an integer"
else
    echo "No support for other distros atp"
fi
