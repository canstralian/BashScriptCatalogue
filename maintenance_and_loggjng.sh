#!/bin/bash

# Function to perform maintenance tasks and log the actions.

# @param $1: The action to be performed for maintenance.
maintenance_and_logging() {
    local action="$1"  # Capture the action passed as a parameter.
    local log_file="maintenance_log.txt"  # Define the log file name.

    # Check if the log file exists, if not create a new one.
    if [ ! -f "$log_file" ]; then
        touch "$log_file"
    fi

    # Get the current date and time for logging.
    local current_datetime
    current_datetime=$(date +"%Y-%m-%d %H:%M:%S")

    # Log the action along with the timestamp.
    echo "[$current_datetime] Action: $action" >> "$log_file"

    # Perform the maintenance action based on the input.
    case "$action" in
        "backup")
            echo "Performing backup..."
            # Add backup logic here
            ;;
        "cleanup")
            echo "Performing cleanup..."
            # Add cleanup logic here
            ;;
        "update")
            echo "Performing system update..."
            # Add update logic here
            ;;
        *)
            echo "Invalid action. Available actions: backup, cleanup, update."
            ;;
    esac
}

# Usage examples for maintenance_and_logging function

# Example 1: Perform backup and log the action.
maintenance_and_logging "backup"

# Example 2: Perform cleanup and log the action.
maintenance_and_logging "cleanup"

# Example 3: Perform system update and log the action.
maintenance_and_logging "update"