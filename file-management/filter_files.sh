#!/bin/bash

# Function to filter files and folders in a directory based on their age and name.
# The function takes a directory path and a number of days as input.
# It filters the files and folders in the directory that are older than the specified number of days
# and have a filename starting with a 9-digit number followed by ".sf_export_finished".
# It then creates a new directory in the specified directory.

# @param $1: The directory path to filter.
# @param $2: The number of days to consider for filtering.
filterFiles() {
    local directory="$1"  # Capture the directory path passed as a parameter.
    local days="$2"  # Capture the number of days passed as a parameter.

    # Check if the directory exists
    if [ ! -d "$directory" ]; then
        echo "Directory does not exist."
        exit 1
    fi

    # Filter files and folders older than the specified number of days and starting with a 9-digit number followed by ".sf_export_finished"
    find "$directory" -type f -mtime +"$days" -name '?????????.sf_export_finished' -exec echo {} \;

    # Create a new directory in the specified directory
    local newDirectory="$directory/new_directory"
    mkdir "$newDirectory"
    echo "New directory created: $newDirectory"
}

# Usage example for filterFiles function

# Example: Filter files and folders in the directory "/path/to/directory" that are older than 7 days
# and have a filename starting with a 9-digit number followed by ".sf_export_finished".
# Then create a new directory in the same directory.
filterFiles "/path/to/directory" 7