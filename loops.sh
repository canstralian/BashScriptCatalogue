#!/bin/bash

# Function to loop through files with multiple name patterns.
# This function takes a list of file name patterns as input and loops through all files that match any of the patterns.
# It then performs a specific action on each file.

# @param $1: List of file name patterns separated by spaces.
# @param $2: Action to perform on each file.
loopThroughFiles() {
    local patterns=($1)  # Convert the input string of patterns into an array.
    local action="$2"  # Capture the action to perform on each file.

    for pattern in "${patterns[@]}"; do
        # Use the find command to search for files that match the current pattern.
        # The -type f option ensures that only regular files are considered.
        # The -name option specifies the pattern to match against the file names.
        # The -print0 option separates the file names with null characters to handle filenames with spaces or special characters.
        # The while loop reads the null-separated file names and performs the specified action on each file.
        find . -type f -name "$pattern" -print0 | while IFS= read -r -d '' file; do
            # Perform the specified action on the file.
            eval "$action \"$file\""
        done
    done
}

# Usage example for loopThroughFiles.sh

# Example: Loop through files with name patterns "*.txt" and "*.csv" and print the file names.
loopThroughFiles "*.txt *.csv" "echo File:"

# Example: Loop through files with name pattern "*.jpg" and delete each file.
loopThroughFiles "*.jpg" "rm -f"

# Example: Loop through files with name pattern "*.log" and count the number of lines in each file.
loopThroughFiles "*.log" "wc -l"