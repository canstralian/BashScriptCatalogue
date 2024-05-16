#!/bin/bash

# Function to generate a cross-reference (concordance) on a target file.
# The output will be a listing of all word occurrences in the target file,
# along with the line numbers in which each word occurs.
#
# @param $1: The target file to generate the cross-reference for.
generateCrossReference() {
    local file="$1"  # Capture the target file passed as a parameter.

    # Check if the file exists.
    if [ ! -f "$file" ]; then
        echo "File '$file' does not exist."
        exit 1
    fi

    # Create an associative array to store the word occurrences and line numbers.
    declare -A crossReference

    # Read the file line by line.
    while IFS= read -r line; do
        # Split the line into words.
        words=($line)

        # Iterate over the words.
        for word in "${words[@]}"; do
            # Remove any leading or trailing punctuation marks.
            word=$(echo "$word" | sed 's/^[[:punct:]]*//;s/[[:punct:]]*$//')

            # Check if the word is already in the cross-reference array.
            if [ "${crossReference[$word]+_}" ]; then
                # Append the line number to the existing word entry.
                crossReference[$word]+=" $lineNumber"
            else
                # Add a new entry for the word in the cross-reference array.
                crossReference[$word]="$lineNumber"
            fi
        done

        # Increment the line number.
        lineNumber=$((lineNumber + 1))
    done < "$file"

    # Print the cross-reference.
    for word in "${!crossReference[@]}"; do
        echo "$word: ${crossReference[$word]}"
    done
}

# Usage example for generateCrossReference.sh

# Example: Generate cross-reference for the file "target.txt".
generateCrossReference "target.txt"