#!/bin/bash


#   Here I declare some reusable variables and contrain them.
typeset -l yn=""
typeset -i distro=0
typeset -l ParrotKeyYN=""


#   Greetings!!!
echo "Hello, friend!"

#   Do you want to use my program?
echo "Would you like to add Parrot repos to your sources list? (y/n)"
read -p "Please enter y or n: " yn

if [[ $yn == "y" || $yn == "Y" ]]
then
    echo "Great! Let's proceed."

    echo "What distro are you using? (more will be added later)"
    read -p "1=Ubuntu/Debian, 2=Rocky/Fedora: (int pls)" distro

#   Check if the input is a valid integer
    if [ -z $distro ] || [ $distro -eq 0 ]
    then
        echo "Please enter an integer"
        exit 1

###DEBIAN/UBUNTU
    elif [ $distro -eq 1 ]
    then
        echo "Changes will be made to your /etc/apt/sources.list file."

##KEYS
#   Is there already a Parrot GPG key? Is it empty?
        parrotKeyPath1="/etc/apt/trusted.gpg.d/parrot.gpg"
        echo "checking if $parrotKeyPath1 exists..."
        if [[ -e $parrotKeyPath1 ]]; then
            echo "Parrot GPG key already present. Checking for data present..."
            if [[ -s $parrotKeyPath1 ]]; then
                echo "Parrot GPG key is present and has data."
            else
#   If the key is present but empty, ask the user if they want to remove it and create a new one.
                echo "Parrot GPG key is present but empty. Shall I remove it and create a new one?"
                read -p "Please enter y or n: " ParrotKeyYN

                if [[ $ParrotKeyYN == "y" || $ParrotKeyYN == "Y" ]]; then
                    echo "Removing empty Parrot GPG key..."
                    sudo rm -f $parrotKeyPath1
                    echo "Creating new Parrot GPG key..."
#   fail silently, silent mode, show errors, and follow redirects. Pipe output to gpg to convert it to a binary format and save it to the specified path.
                    curl -fsSL https://deb.parrot.sh/parrot/misc/parrot.gpg | sudo gpg --dearmor -o $parrotKeyPath1
                    if [[ $? -ne 0 ]]; then
                        echo "Failed to create Parrot GPG key. Please check your network connection or the URL."
                        exit 1
                    else
                        echo "Parrot GPG key created successfully!"
                    fi
                elif [[ $ParrotKeyYN == "n" || $ParrotKeyYN == "N" ]]; then
                    echo "Keeping the empty Parrot GPG key."
                else
                    echo "Invalid input. Please enter y or n."
                    exit 1
                fi
            fi
#   Key didn't exist, so create it.
        else
            echo "Creating new Parrot GPG key..."
            curl -fsSL https://deb.parrot.sh/parrot/misc/parrot.gpg | sudo gpg --dearmor -o $parrotKeyPath1
            if [[ $? -ne 0 ]]; then
                echo "Failed to create Parrot GPG key. Please check your network connection or the URL."
                exit 1
            else
                echo "Parrot GPG key created successfully!"
            fi
        fi

##LISTS
#   Check if the Parrot repository list exists, and if not, create it.
        parrotListPath1="/etc/apt/sources.list.d/parrot.list"
        echo "Checking if $parrotListPath1 exists..."
        if [[ -e $parrotListPath1 ]]; then
            echo "Adding Parrot repos to your sources list at $parrotListPath1"
            echo "deb https://deb.parrot.sh/parrot/ lory main contrib non-free non-free-firmware" | sudo tee -a $parrotListPath1
            echo "deb https://deb.parrot.sh/parrot/ lory-security main contrib non-free non-free-firmware" | sudo tee -a $parrotListPath1
            echo "Parrot repos added successfully!"
        elif [[ -d "/etc/apt/sources.list.d" ]]; then
            echo "Creating parrot.list in /etc/apt/sources.list.d"
            sudo touch $parrotListPath1
            echo "Adding Parrot repos to your sources list at $parrotListPath1"
            echo "deb https://deb.parrot.sh/parrot/ lory main contrib non-free non-free-firmware" | sudo tee -a $parrotListPath1
            echo "deb https://deb.parrot.sh/parrot/ lory-security main contrib non-free non-free-firmware" | sudo tee -a $parrotListPath1
            echo "Parrot repos added successfully!"
        else
            echo "Could not find /etc/apt/sources.list.d; Please check your system."
            exit 1
        fi

###FEDORA/ROCKY
    elif [ $distro -eq 2 ]
    then
        echo "Changes will be made to your /etc/yum.repos.d/parrot.repo file."

##KEYS
#   Is there already a Parrot GPG key? Is it empty?
        parrotKeyPath2="/etc/pki/rpm-gpg/RPM-GPG-KEY-Parrot"

##LISTS
#   Check if the Parrot repo list exists, and if not, create it.
        parrotListPath2="/etc/yum.repos.d/parrot.repo"
        echo "Checking if  $parrotListPath2 exists..."
        if [[ -e $parrotListPath2 ]]; then
            echo "Adding Parrot repos to your sources list at $parrotListPath2"
            echo "deb https://deb.parrot.sh/parrot/ lory main contrib non-free non-free-firmware" | sudo tee -a $parrotListPath2
            echo "deb https://deb.parrot.sh/parrot/ lory-security main contrib non-free non-free-firmware" | sudo tee -a $parrotListPath2
            echo "Parrot repos added successfully!"
        elif [[ -d "/etc/yum.repos.d" ]]; then
            echo "Creating parrot.repo in /etc/yum.repos.d"
            sudo touch $parrotListPath2
            echo "Adding Parrot repos to your sources list at $parrotListPath2"
            echo "deb https://deb.parrot.sh/parrot/ lory main contrib non-free non-free-firmware" | sudo tee -a $parrotListPath2
            echo "deb https://deb.parrot.sh/parrot/ lory-security main contrib non-free non-free-firmware" | sudo tee -a $parrotListPath2
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