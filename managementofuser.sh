#!/bin/bash

# Must run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (use sudo)"
    exit 1
fi

while true
do
    echo "-----------------------------------"
    echo "Choose an option:"
    echo "1. Add User"
    echo "2. Create Group"
    echo "3. Add User to Group"
    echo "4. Give Sudo Permission to User"
    echo "5. Check if User Exists"
    echo "6. Check if Group Exists"
    echo "7. Delete User"
    echo "8. Delete Group"
    echo "9. Remove User from Sudo"
    echo "0. Exit"
    echo "-----------------------------------"
    
    read -p "Enter option number: " option

    case $option in

        1)
            read -p "Enter username: " username
            adduser "$username"
            ;;

        2)
            read -p "Enter group name: " groupname
            groupadd "$groupname"
            echo "Group created."
            ;;

        3)
            read -p "Enter username: " username
            read -p "Enter group name: " groupname
            usermod -aG "$groupname" "$username"
            echo "User added to group."
            ;;

        4)
            read -p "Enter username: " username
            usermod -aG sudo "$username"
            echo "Sudo permission granted."
            ;;

        5)
            read -p "Enter username: " username
            if id "$username" &>/dev/null; then
                echo "User exists."
            else
                echo "User does not exist."
            fi
            ;;

        6)
            read -p "Enter group name: " groupname
            if getent group "$groupname" > /dev/null; then
                echo "Group exists."
            else
                echo "Group does not exist."
            fi
            ;;

        7)
            read -p "Enter username to delete: " username
            userdel -r "$username"
            echo "User deleted."
            ;;

        8)
            read -p "Enter group name to delete: " groupname
            groupdel "$groupname"
            echo "Group deleted."
            ;;

        9)
            read -p "Enter username: " username
            gpasswd -d "$username" sudo
            echo "User removed from sudo group."
            ;;

        0)
            echo "Exiting..."
            exit 0
            ;;

        *)
            echo "Invalid option!"
            ;;

    esac

done
