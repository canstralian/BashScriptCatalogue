#!/bin/bash

# Function to perform grep on a given result from "Logical Displays" to "DIsplazModelDirector".
# The function takes two parameters:
#   - $1: The input file to search in.
#   - $2: The output file to store the grep result.

grepLogicalDisplaysToDIsplazModelDirector() {
    local inputFile="$1"
    local outputFile="$2"

    # Perform grep on the input file and store the result in the output file.
    grep -E "Logical Displays.*DIsplazModelDirector" "$inputFile" > "$outputFile"
}

# Usage example for grepLogicalDisplaysToDIsplazModelDirector function.

# Example: Perform grep on "input.txt" and store the result in "output.txt".
grepLogicalDisplaysToDIsplazModelDirector "input.txt" "output.txt"