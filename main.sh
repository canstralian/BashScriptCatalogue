#!/bin/bash

# Script Name: main.sh
# Description: A modular bash script with menu interface for executing other bash scripts.
# Author: [Your Name]
# Date: [Current Date]

# Logging function
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> script.log
}

# Function to display the main menu
display_main_menu() {
    clear
    echo "Select a category:"
    echo "1. File Operations"
    echo "2. Remote Operations"
    echo "3. Backup Operations"
    echo "4. Exit"
}

# Function to display File Operations submenu
display_file_operations_menu() {
    clear
    echo "File Operations:"
    echo "1. Remove .pgp.txt extension (remove_pgp.sh)"
    echo "2. Back to main menu"
}

# Function to display Remote Operations submenu
display_remote_operations_menu() {
    clear
    echo "Remote Operations:"
    echo "1. Copy files to remote server (copy_to_remote_server.sh)"
    echo "2. Back to main menu"
}

# Function to display Backup Operations submenu
display_backup_operations_menu() {
    clear
    echo "Backup Operations:"
    echo "1. Create rolling backups of /etc (rolling_backup_etc.sh)"
    echo "2. Back to main menu"
}

# Function to execute remove_pgp.sh
execute_remove_pgp() {
    # Usage example: remove .pgp.txt extension from the file "example.pgp.txt" in the path "/path/to/file"
    ./remove_pgp.sh "/path/to/file" "example.pgp.txt"
    log "remove_pgp.sh executed"
}

# Function to execute copy_to_remote_server.sh
execute_copy_to_remote_server() {
    # Usage example: Copy files from "/source/path" to the remote server
    ./copy_to_remote_server.sh "/source/path" "/destination/path" "username@remote-server-ip"
    log "copy_to_remote_server.sh executed"
}

# Function to execute rolling_backup_etc.sh
execute_rolling_backup() {
    # Usage example: Create rolling backups
    ./rolling_backup_etc.sh
    log "rolling_backup_etc.sh executed"
}

# Main function
main() {
    while true; do
        display_main_menu
        read -rp "Enter your choice: " main_choice
        case $main_choice in
            1)  # File Operations submenu
                while true; do
                    display_file_operations_menu
                    read -rp "Enter your choice: " file_choice
                    case $file_choice in
                        1) execute_remove_pgp ;;
                        2) break ;;
                        *) echo "Invalid choice"; sleep 2 ;;
                    esac
                done
                ;;
            2)  # Remote Operations submenu
                while true; do
                    display_remote_operations_menu
                    read -rp "Enter your choice: " remote_choice
                    case $remote_choice in
                        1) execute_copy_to_remote_server ;;
                        2) break ;;
                        *) echo "Invalid choice"; sleep 2 ;;
                    esac
                done
                ;;
            3)  # Backup Operations submenu
                while true; do
                    display_backup_operations_menu
                    read -rp "Enter your choice: " backup_choice
                    case $backup_choice in
                        1) execute_rolling_backup ;;
                        2) break ;;
                        *) echo "Invalid choice"; sleep 2 ;;
                    esac
                done
                ;;
            4) echo "Exiting..."; exit ;;
            *) echo "Invalid choice"; sleep 2 ;;
        esac
    done
}

# Execute the main function
main