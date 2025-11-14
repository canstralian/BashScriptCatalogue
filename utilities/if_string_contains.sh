#!/bin/bash

# Function to check if a given string contains the word "gmail".
# This function uses a brute force approach to search for the word "gmail" in the string.

# @param $1: The string to check.
# @return: Outputs "Found" if the string contains "gmail", otherwise outputs "Not Found".
brutte_forse_gmail() {
    local string="$1"  # Capture the string passed as a parameter.

    # Loop through each character in the string.
    for ((i = 0; i < ${#string}; i++)); do
        # Check if the current character and the next two characters form the word "gmail".
        if [[ "${string:i:1}" == "g" && "${string:i+1:1}" == "m" && "${string:i+2:1}" == "a" && "${string:i+3:1}" == "i" && "${string:i+4:1}" == "l" ]]; then
            echo "Found"
            return
        fi
    done

    echo "Not Found"
}

# Usage example for brutte_forse_gmail.sh

# Example 1: Check if the string "example@gmail.com" contains the word "gmail".
echo "Example 1:"
echo "---------"
brutte_forse_gmail "example@gmail.com"
echo ""  # Empty line for readability.

# Example 2: Check if the string "hello world" contains the word "gmail".
echo "Example 2:"
echo "---------"
brutte_forse_gmail "hello world"
echo ""  # Empty line for readability.

# Example 3: Check if the string "gmail" contains the word "gmail".
echo "Example 3:"
echo "---------"
brutte_forse_gmail "gmail"
echo ""  # Empty line for readability.