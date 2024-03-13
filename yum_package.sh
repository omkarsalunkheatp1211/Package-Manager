#!/bin/bash

# Check for root access
if [ "${UID}" -ne 0 ]; then
    echo 'Please run with sudo or root.'
    exit 1
fi

# Send user information via email
TO="omkarsalunkhe1211@gmail.com"

# Get current date and time
CURRENT_DATE_TIME=$(date +"%d-%m-%Y %I:%M:%S %p")

# Function for displaying welcome banner
function welcomeBanner {
    echo "------------------"
    echo "     Welcome"
    echo "------------------"
}

# Function for installing Package
function install {
    if yum install $PACKAGE_NAME; then
        echo "Package $PACKAGE_NAME successfully installed."
	# Send user information via email
	echo -e "Package $PACKAGE_NAME successfully installed.\nTime & Date: $CURRENT_DATE_TIME" | mail -s "PACKAGE ALERT!" "${TO}"
    else
        echo "Failed to install package $PACKAGE_NAME."
       	echo -e "Failed to install package $PACKAGE_NAME.\nTime & Date: $CURRENT_DATE_TIME" | mail -s "PACKAGE ALERT!" "${TO}"
    fi
}

# Function for removing Package
function remove {
    if yum remove $PACKAGE_NAME; then
        echo "Package $PACKAGE_NAME successfully removed."
	echo -e "Package $PACKAGE_NAME successfully removed.\nTime & Date: $CURRENT_DATE_TIME" | mail -s "PACKAGE ALERT!" "${TO}"
    else
        echo "Failed to remove package $PACKAGE_NAME."
	 echo -e "Failed to remove package $PACKAGE_NAME.\nTime & Date: $CURRENT_DATE_TIME" | mail -s "PACKAGE ALERT!" "${TO}"
    fi
}

# Function for updating Package
function update {
    if yum update $PACKAGE_NAME; then
        echo "Package $PACKAGE_NAME successfully updated."
	echo -e "Package $PACKAGE_NAME successfully updated.\nTime & Date: $CURRENT_DATE_TIME" | mail -s "PACKAGE ALERT!" "${TO}"
 else
        echo "Failed to update package $PACKAGE_NAME."
	echo "Failed to update package $PACKAGE_NAME.\nTime & Date: $CURRENT_DATE_TIME" | mail -s "PACKAGE ALERT!" "${TO}"
    fi
}

# Function for displaying installed packages
function listInstalledPackages {
    echo "Installed Packages:"
    yum list installed
}

# Function for displaying exit banner
function exitBanner {
    echo "------------------"
    echo "    Thank you"
    echo "------------------"
}

# Main Script
welcomeBanner

# Check if yum is available
if ! command -v yum &> /dev/null; then
    echo "Error: YUM package manager not found. This script is designed for systems using YUM."
    exit 1
fi

while true; do
    echo "Choose options:"
    echo "A) Install Packages"
    echo "B) Remove Packages"
    echo "C) Update Package"
    echo "D) List Installed Packages"
    echo "E) Exit"
    read -p "Enter your choice (A/B/C/D/E): " choice

    case $choice in
        A|a)
            read -p "Enter the package name: " PACKAGE_NAME
            install ;;
        B|b)
            read -p "Enter the package name: " PACKAGE_NAME
            remove ;;
        C|c)
            read -p "Enter the package name: " PACKAGE_NAME
            update ;;
        D|d) listInstalledPackages ;;
        E|e)
            exitBanner
            exit ;;
        *) echo "Invalid Choice" ;;
    esac
done

