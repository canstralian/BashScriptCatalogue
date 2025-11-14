#!/bin/bash

# Function to convert Windows PID to process name.
# Takes a Windows PID as input and returns the process name associated with the PID.
# The function uses the 'tasklist' command to retrieve the process information and filters it based on the provided PID.
# If the PID is not found or if there is an error, an error message is displayed.

# @param $1: The Windows PID to convert.
# @return: Outputs the process name associated with the PID.
convertWindowsPidToProcessName() {
    local pid="$1"  # Capture the Windows PID passed as a parameter.

    # Use 'tasklist' command to retrieve process information and filter based on the provided PID.
    local processName
    processName=$(tasklist /FI "PID eq $pid" /FO CSV | tail -n 1 | awk -F "\"*,\"*" '{print $1}')

    if [ -z "$processName" ]; then
        echo "Process not found for PID: $pid"
    else
        echo "$processName"
    fi
}

# Usage example for convertWindowsPidToProcessName.sh

# Example: Convert Windows PID 1234 to process name.
pid=1234
echo "Process name for PID $pid: $(convertWindowsPidToProcessName "$pid")"