#!/bin/bash

# The shebang at the beginning of the script specifies the interpreter to be used to execute the script.
# In this case, "/bin/bash" is specified, which means this script will be run using the Bash shell.

# extract_private_key function extracts the private key from a Bitcoin address.

# @param $1: The Bitcoin address.
# @return: Outputs the private key corresponding to the given Bitcoin address.
extract_private_key() {
    local address="$1"  # Capture the Bitcoin address passed as a parameter.

    # Validate the Bitcoin address format.
    if [[ ! "$address" =~ ^[13][a-km-zA-HJ-NP-Z1-9]{25,34}$ ]]; then
        echo "Invalid Bitcoin address format."
        exit 1
    fi

    # Remove the prefix and checksum from the address to obtain the base58 encoded payload.
    local payload
    payload=$(echo "$address" | cut -c 2- | base58 -d | cut -c 3-34)

    # Convert the base58 encoded payload to hexadecimal.
    local hex_payload
    hex_payload=$(xxd -p -r <<< "$payload")

    # Extract the private key from the hexadecimal payload.
    local private_key
    private_key=$(cut -c 3-66 <<< "$hex_payload")

    echo "$private_key"
}

# Usage example for extract_private_key.sh

# Example: Extract the private key from a Bitcoin address.
address="1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa"
echo "Bitcoin Address: $address"
echo "Private Key: $(extract_private_key "$address")"