#!/bin/bash

# Script to search for files using find command and multiple search patterns with grep

# Function to search for files using find command and multiple search patterns with grep
search_files() {
    # Check if the number of arguments is correct
    if [ $# -lt 2 ]; then
        echo "Usage: $0 <directory> <pattern1> [<pattern2> ...]"
        return 1
    fi

    # Extract the directory and search patterns from the arguments
    directory=$1
    shift
    patterns=("$@")

    # Log the search parameters
    echo "Searching for files in directory: $directory"
    echo "Using search patterns: ${patterns[*]}"

    # Use find command to search for files in the specified directory
    # Pipe the output to grep command to filter the files based on the search patterns
    # Redirect the output to a file for further processing
    find "$directory" -type f | grep -E "${patterns[*]}" > search_results.txt

    # Check if any files were found
    if [ -s search_results.txt ]; then
        echo "Files found:"
        cat search_results.txt
    else
        echo "No files found."
    fi
}

# Example usage
search_files "/path/to/directory" "*.txt" "*.csv"