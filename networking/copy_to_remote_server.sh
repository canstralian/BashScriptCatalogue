#!/bin/bash

# Function to copy files from local hard drive to a remote server.
# @param $1: The source directory path on the local hard drive.
# @param $2: The destination directory path on the remote server.
# @param $3: The username and IP address of the remote server.
copyFilesToRemoteServer() {
    local sourceDir="$1"
    local destinationDir="$2"
    local remoteServer="$3"

    # Check if the source directory exists.
    if [ ! -d "$sourceDir" ]; then
        echo "Source directory does not exist."
        exit 1
    fi

    # Check if the destination directory exists on the remote server.
    ssh "$remoteServer" "[ -d $destinationDir ]" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Destination directory does not exist on the remote server."
        exit 1
    fi

    # Copy files from the source directory to the destination directory on the remote server.
    rsync -avz "$sourceDir" "$remoteServer:$destinationDir"
}

# Usage example for copyFilesToRemoteServer.sh

# Example: Copy files from "/Volumes/My Passport/4. HERVs in exh T cells" to the remote server at "u253655@10.142.120.18".
copyFilesToRemoteServer "/Volumes/My Passport/4. HERVs in exh T cells" "/path/to/destination" "u253655@10.142.120.18"