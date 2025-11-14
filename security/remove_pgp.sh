#!/bin/bash

# Function to remove .pgp.txt extension from a specific file name in a specific path
removeExtension() {
    local path="$1"
    local filename="$2"

    local extension=".pgp.txt"
    local newFilename="${filename%$extension}"

    echo "$path/$newFilename"
}

# Usage example for removeExtension.sh

# Example: Remove .pgp.txt extension from the file "example.pgp.txt" in the path "/path/to/file"
echo "Example:"
echo "--------"
echo "New file name: $(removeExtension "/path/to/file" "example.pgp.txt")"