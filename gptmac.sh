
# Define the application process name
$processName = "Google Chrome"

# Define the idle time (in seconds) before power saving mode is initiated
$idleTime = 300

# Get the process ID of the application
$processPid = $(pgrep $processName)

# Start a loop to check for idle time
while true; do
    # Get the last input time of the user
    lastInput=$(ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print int($NF/1000000000); exit}')

    # Calculate the idle time since last user input
    idleSeconds=$(( $(date +%s) - $lastInput ))

    # Check if the idle time is greater than the defined idle time
    if [ $idleSeconds -ge $idleTime ]; then
        # If the idle time is greater than or equal to the defined idle time,
        # initiate power saving mode for the application
        kill -STOP $processPid
    fi

    # Wait for 1 second before checking again
    sleep 1
done
