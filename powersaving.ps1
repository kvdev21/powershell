Write-Host "Starting power-saving script..."

# Set the idle time in seconds
$idleTime = 60
Write-Host "Idle time set to $idleTime seconds."

# Specify the list of applications to target
$applications = "notepad", "chrome"
Write-Host "Targeting the following applications: $applications"

while ($true) {
    # Loop through the applications
    foreach ($application in $applications) {
        Write-Host "Checking $application..."

        # Get the process for the application
        $process = Get-Process $application -ErrorAction SilentlyContinue

        # Check if the process exists and is running
        if ($process -and $process.Responding) {

            # Get the last time the process responded
            $lastResponded = $process.Responding
            Write-Host "lastResponded $lastResponded..."
            
            # Get the process start time
            $startTime = $process.StartTime

            # Calculate the idle time
            $idle = (New-TimeSpan -Start $startTime).TotalSeconds

            # Check if the process is idle
            if (!$lastResponded -and $idle -gt $idleTime -and ![System.Windows.Input.Keyboard]::KeyAvailable ) {
                Write-Host "$application is idle. Setting priority to idle..."
                # Set the process priority to low
                $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::Idle
            }
            else {
                Write-Host "$application is not idle."
            }
        }
        else {
            Write-Host "$application is not running."
        }
    }

    Write-Host "idleTime $idle..."

    Write-Host "Waiting for 1 minutes..."
    Start-Sleep -Seconds 60
}

Write-Host "Power-saving script complete."
