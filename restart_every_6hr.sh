#!/bin/bash

# Function to restart the script every 6 hours with the given command.
# The function checks if 64-bit or 32-bit Java is detected and executes the corresponding command.

auto_restart_script() {
    local command="$1"  # The command to execute when restarting the script.

    while true; do
        # Restart the script every 6 hours.
        sleep 6h

        # Get the current directory of the script.
        local INSTDIR="$(dirname "$0")"
        cd "$INSTDIR"
        INSTDIR="$(pwd)"

        # Check if 64-bit Java is detected.
        if "${INSTDIR}/jre64/bin/java" -version > /dev/null 2>&1; then
            echo "64-bit Java detected"
            export PATH="${INSTDIR}/jre64/bin:$PATH"
            export LD_LIBRARY_PATH="${INSTDIR}/linux64:${INSTDIR}/natives:${INSTDIR}:${INSTDIR}/jre64/lib/amd64:${LD_LIBRARY_PATH}"
            JSIG="libjsig.so"
            LD_PRELOAD="${LD_PRELOAD}:${JSIG}" ./ProjectZomboid64 "$@"
        # Check if 32-bit Java is detected.
        elif "${INSTDIR}/jre/bin/java" -client -version > /dev/null 2>&1; then
            echo "32-bit Java detected"
            export PATH="${INSTDIR}/jre/bin:$PATH"
            export LD_LIBRARY_PATH="${INSTDIR}/linux32:${INSTDIR}/natives:${INSTDIR}:${INSTDIR}/jre/lib/i386:${LD_LIBRARY_PATH}"
            JSIG="libjsig.so"
            LD_PRELOAD="${LD_PRELOAD}:${JSIG}" ./ProjectZomboid32 "$@"
        else
            echo "Couldn't determine 32/64 bit of Java"
        fi

        # Execute the given command before restarting the script.
        eval "$command"
    done
}

# Unit Test for auto_restart_script

# Positive case: Test auto_restart_script with a command that echoes "Restarting script...".
test_auto_restart_script_1() {
    local command="echo 'Restarting script...'"
    auto_restart_script "$command"
}

# Negative case: Test auto_restart_script with an empty command.
test_auto_restart_script_2() {
    local command=""
    auto_restart_script "$command"
}

# Edge case: Test auto_restart_script with a command that terminates the script.
test_auto_restart_script_3() {
    local command="exit 0"
    auto_restart_script "$command"
}

# Usage example for auto_restart_script

# Example: Restart the script every 6 hours and echo "Script restarted" before each restart.
echo "Example:"
echo "--------"
echo "Restarting the script every 6 hours..."
auto_restart_script "echo 'Script restarted'"

exit 0