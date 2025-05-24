#!/bin/bash

typeset -l yn=""
typeset -i distro=0

echo "Hello, friend!"

echo "Would you like to add Parrot repos to your sources list? (y/n)"
read -p "Please enter y or n: " yn

if [[ $yn == "y" || $yn == "Y" ]]
then
    echo "Great! Let's proceed."

    echo "What distro are you using? (more will be added later)"
    read -p "1=Ubuntu/Debian, 2=Rocky/Fedora: (int pls)" distro

    if [ -z $distro ] || [ $distro -eq 0 ]
    then
        echo "Please enter an integer"
        exit 1
    elif [ $distro -eq 1 ]
    then
        echo "Changes will be made to your /etc/apt/sources.list file."

        if [[ -e "/etc/apt/sources.list.d/parrot.list" ]]; then
            echo "Adding Parrot repos to your sources list at /etc/apt/sources.list.d/parrot.list"
            echo "deb https://deb.parrot.sh/parrot/ rolling main contrib non-free" | sudo tee -a /etc/apt/sources.list.d/parrot.list
            echo "deb https://deb.parrot.sh/parrot/ rolling-security main contrib non-free" | sudo tee -a /etc/apt/sources.list.d/parrot.list
            echo "Parrot repos added successfully!"
        elif [[ -d "/etc/apt/sources.list.d" ]]; then
            echo "Creating parrot.list in /etc/apt/sources.list.d"
            sudo touch /etc/apt/sources.list.d/parrot.list
            echo "Adding Parrot repos to your sources list at /etc/apt/sources.list.d/parrot.list"
            echo "deb https://deb.parrot.sh/parrot/ rolling main contrib non-free" | sudo tee -a /etc/apt/sources.list.d/parrot.list
            echo "deb https://deb.parrot.sh/parrot/ rolling-security main contrib non-free" | sudo tee -a /etc/apt/sources.list.d/parrot.list
            echo "Parrot repos added successfully!"
        else
            echo "Could not find /etc/apt/sources.list.d; Please check your system."
            exit 1
        fi

    elif [ $distro -eq 2 ]
    then
        echo "Changes will be made to your /etc/yum.repos.d/parrot.repo file."

        if [[ -e "etc/yum.repos.d/parrot.repo" ]]; then
            echo "Adding Parrot repos to your sources list at /etc/yum.repos.d/parrot.repo"
            echo "deb https://deb.parrot.sh/parrot/ rolling main contrib non-free" | sudo tee -a /etc/yum.repos.d/parrot.repo
            echo "deb https://deb.parrot.sh/parrot/ rolling-security main contrib non-free" | sudo tee -a /etc/yum.repos.d/parrot.repo
            echo "Parrot repos added successfully!"
        elif [[ -d "/etc/yum.repos.d" ]]; then
            echo "Creating parrot.repo in /etc/yum.repos.d"
            sudo touch /etc/yum.repos.d/parrot.repo
            echo "Adding Parrot repos to your sources list at /etc/yum.repos.d/parrot.repo"
            echo "deb https://deb.parrot.sh/parrot/ rolling main contrib non-free" | sudo tee -a /etc/yum.repos.d/parrot.repo
            echo "deb https://deb.parrot.sh/parrot/ rolling-security main contrib non-free" | sudo tee -a /etc/yum.repos.d/parrot.repo
            echo "Parrot repos added successfully!"
        else
            echo "Could not find /etc/apt/sources.list. Please check your system."
        fi
    else
        echo "No support for other distros atp"
    fi

elif [[ $yn == "n" || $yn == "N" ]]
then
    echo "No problem. Next step..."
else
    echo "Invalid input. Please enter y or n."
    exit 1
fi


exit 0
# End of script
# This script is designed to add Parrot repositories to the sources list of Ubuntu/Debian or Rocky/Fedora systems.
# It checks the user's input for confirmation and the type of distribution before proceeding.
# It appends the necessary repository information to the appropriate sources list file.
# Note: This script requires superuser privileges to modify system files.