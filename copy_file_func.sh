#!/bin/bash

# Copy a file from one location to another.

# @param $1: The source file path.
# @param $2: The destination file path.
# @return: Outputs a success message if the file is copied successfully, or an error message if the copy operation fails.
copyFile() {
    local source="$1"  # Capture the source file path passed as a parameter.
    local destination="$2"  # Capture the destination file path passed as a parameter.

    # Check if the source file exists.
    if [ ! -f "$source" ]; then
        echo "Source file does not exist."
        return 1
    fi

    # Check if the destination file already exists.
    if [ -f "$destination" ]; then
        echo "Destination file already exists."
        return 1
    fi

    # Copy the file from source to destination.
    cp "$source" "$destination"

    # Check if the copy operation was successful.
    if [ "$?" -eq 0 ]; then
        echo "File copied successfully."
    else
        echo "Failed to copy file."
    fi
}

# Usage example for copyFile.sh

# Example: Copy file from location ABC to location xyz.
copyFile "/path/to/source/file" "/path/to/destination/file"