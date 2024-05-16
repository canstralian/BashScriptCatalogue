#!/bin/bash

# Function to start screens and run commands in each screen.
# This function starts 3 screens, goes to a folder in each screen, and runs a command.

start_screens_and_run_commands() {
    # Start the first screen
    screen -dmS screen1

    # Go to the desired folder in the first screen
    screen -S screen1 -X stuff "cd /path/to/folder1$(printf \\r)"

    # Run the command in the first screen
    screen -S screen1 -X stuff "command1$(printf \\r)"

    # Start the second screen
    screen -dmS screen2

    # Go to the desired folder in the second screen
    screen -S screen2 -X stuff "cd /path/to/folder2$(printf \\r)"

    # Run the command in the second screen
    screen -S screen2 -X stuff "command2$(printf \\r)"

    # Start the third screen
    screen -dmS screen3

    # Go to the desired folder in the third screen
    screen -S screen3 -X stuff "cd /path/to/folder3$(printf \\r)"

    # Run the command in the third screen
    screen -S screen3 -X stuff "command3$(printf \\r)"
}

# Usage example for start_screens_and_run_commands.sh

# Call the function to start screens and run commands
start_screens_and_run_commands