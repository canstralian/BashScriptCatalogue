#!/bin/bash

# Function to create rolling weekly backups of /etc for the last 4 weeks.
createRollingBackups() {
    local backupDir="/path/to/backup/directory"  # Specify the backup directory path.

    # Create the backup directory if it doesn't exist.
    if [ ! -d "$backupDir" ]; then
        mkdir -p "$backupDir"
    fi

    # Calculate the date for the oldest backup to keep.
    local oldestBackupDate=$(date -d "4 weeks ago" +%Y%m%d)

    # Loop through the last 4 weeks and create backups.
    for ((i = 0; i < 4; i++)); do
        local backupDate=$(date -d "$i weeks ago" +%Y%m%d)  # Calculate the backup date.

        # Check if the backup already exists.
        if [ -d "$backupDir/$backupDate" ]; then
            echo "Backup for $backupDate already exists. Skipping..."
        else
            # Create the backup directory for the current week.
            mkdir "$backupDir/$backupDate"

            # Copy the contents of /etc to the backup directory.
            cp -R /etc/* "$backupDir/$backupDate"

            echo "Backup created for $backupDate"
        fi
    done

    # Remove backups older than 4 weeks.
    find "$backupDir" -maxdepth 1 -type d -name "[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]" -not -newermt "$oldestBackupDate" -exec rm -r {} \;

    echo "Rolling weekly backups created successfully."
}

# Usage example for createRollingBackups function.
createRollingBackups