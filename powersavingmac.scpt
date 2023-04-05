 
 
set appName to "Google Chrome"
set idleTimeoutSeconds to 60

-- Get the process associated with the application
set appProcess to (do shell script "ps ax | grep " & quoted form of appName & " | grep -v grep | awk '{print $1}'")

-- If the process was found, set the idle timeout and power-saving mode
if appProcess is not "" then
    -- Set the system to enter power-saving mode after the idle timeout
    do shell script "sudo pmset -a displaysleep " & idleTimeoutSeconds
    do shell script "sudo pmset -a disksleep " & idleTimeoutSeconds

    -- Set the process to lower priority when the system enters power-saving mode
    do shell script "renice +10 " & appProcess

    -- Output a message indicating that power-saving mode has been initiated for the application
    display dialog "Power-saving mode initiated for " & appName & "."
else
    -- Output an error message indicating that the application was not found
    display dialog "Application not found: " & appName & "."
end if
