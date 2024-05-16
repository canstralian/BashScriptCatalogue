#!/bin/bash

# Function to find the 100 newest files on the entire system.
# This function uses the 'find' command to search for files on the entire system,
# sorts them by modification time in reverse order (newest first),
# and outputs the 100 newest files.

find_newest_files() {
    find / -type f -printf '%T@ %p\n' | sort -nr | head -n 100 | cut -d' ' -f2-
}

# Usage example for find_newest_files.sh

echo "Finding the 100 newest files on the entire system:"
echo "-----------------------------------------------"
find_newest_files