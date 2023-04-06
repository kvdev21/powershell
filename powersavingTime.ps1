Write-Host "Starting power-saving script..."

# Specify the list of applications to target
$applications = "notepad"

# Define the start and end times for power-saving mode
$startTime = "13:00"
$endTime = "14:00"

# Loop indefinitely
while ($true) {

    # Get the current time
    $currentTime = Get-Date -Format "HH:mm"

    # If the current time is between the start and end times for power-saving mode
    if ($currentTime -ge $startTime -or $currentTime -lt $endTime) {

        # Put the application into low priority mode
        # Replace 'application.exe' with the name of your application
        $process = Get-Process $application -ErrorAction SilentlyContinue
        $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::Idle

    } else {

        # Restore the application to normal priority
        # Replace 'application.exe' with the name of your application
        $process = Get-Process $application -ErrorAction SilentlyContinue
        $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::Normal

    }

    # Wait for 10 minutes before checking the time again
    Start-Sleep -Seconds 600
}
