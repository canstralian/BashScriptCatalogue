#!/bin/bash

# Function to perform grep on a given result from "Logical Displays" to "DIsplazModelDirector".
# Parameters:
#   $1: The input file or directory to search in.
#   $2: The output file to store the grep result.
#   $3 (optional): Case sensitivity flag (1 for case insensitive, 0 for case sensitive, default is case sensitive).
# Returns: None
grepLogicalDisplaysToDIsplazModelDirector() {
    # Check if the correct number of arguments is provided
    if [ "$#" -lt 2 ]; then
        echo "Usage: grepLogicalDisplaysToDIsplazModelDirector <input> <output> [caseSensitive: 0 or 1]"
        exit 1
    fi

    local inputFile="$1"
    local outputFile="$2"
    local caseSensitive="${3:-0}"  # Default is case sensitive

    # Validate input file or directory existence
    if [ ! -e "$inputFile" ]; then
        echo "Input file or directory not found: $inputFile"
        exit 1
    fi

    # Set grep options based on case sensitivity flag
    local grepOptions=""
    if [ "$caseSensitive" -eq 1 ]; then
        grepOptions="-i"
    fi

    # Perform grep on the input file or directory and store the result in the output file
    grep $grepOptions -r -E "Logical Displays.*DIsplazModelDirector" "$inputFile" > "$outputFile"
}

# Usage example for grepLogicalDisplaysToDIsplazModelDirector function.

# Example: Perform grep on "input.txt" and store the result in "output.txt" with case sensitivity.
grepLogicalDisplaysToDIsplazModelDirector "input.txt" "output.txt" 0