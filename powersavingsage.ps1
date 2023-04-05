# Define the application executable and idle timeout in seconds
$executablePath = "C:\path\to\application.exe"
$idleTimeoutSeconds = 300

# Get the process associated with the application executable
$process = Get-Process | Where-Object {$_.Path -eq $executablePath}

# If the process was found, set the idle timeout and power-saving mode
if ($process) {
  # Set the system to enter power-saving mode after the idle timeout
  powercfg /Change monitor-timeout-ac $idleTimeoutSeconds
  powercfg /Change standby-timeout-ac $idleTimeoutSeconds

  # Set the process to lower priority when the system enters power-saving mode
  $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::BelowNormal

  Write-Output "Power-saving mode initiated for $($process.ProcessName)"
} else {
  Write-Output "Application not found: $executablePath"
}
