# Define the application process name
$processName = "myApplication.exe"

# Define the idle time (in seconds) before power saving mode is initiated
$idleTime = 300

# Define a boolean variable to control the loop
$running = $true

# Get the process ID of the application
$processId = (Get-Process $processName).Id

# Start a loop to check for idle time
while($running) {
    # Get the last input time of the user
    $lastInput = Get-LastInputTime

    # Calculate the idle time since last user input
    $idleSeconds = (Get-Date) - $lastInput

    # Check if the idle time is greater than the defined idle time
    if($idleSeconds.TotalSeconds -ge $idleTime) {
        # If the idle time is greater than or equal to the defined idle time,
        # initiate power saving mode for the application
        Stop-Process -Id $processId -Force
    }

    # Wait for 1 second before checking again
    Start-Sleep -Seconds 1
}

