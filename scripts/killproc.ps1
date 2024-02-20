# Prompt user to input the name of the program
$programName = Read-Host "Enter the name of the program you want to terminate"

# Get all processes matching the input program name
$matchingProcesses = Get-Process | Where-Object { $_.ProcessName -like "*$programName*" }

if ($matchingProcesses) {
    # Display process IDs to the user
    Write-Host "Matching Processes:"
    $matchingProcesses | Format-Table Id, ProcessName, Description -AutoSize

    # Prompt user to select a process to terminate
    $selectedPID = Read-Host "Enter the ID of the process you want to terminate"

    # Check if the entered PID is valid
    $selectedProcess = $matchingProcesses | Where-Object { $_.Id -eq $selectedPID }
    if ($selectedProcess) {
        # Terminate the selected process using taskkill
        taskkill /F /PID $selectedPID
        Write-Host "Process with ID $selectedPID has been terminated."
    } else {
        Write-Host "Invalid process ID. No process terminated."
    }
} else {
    Write-Host "No processes matching '$programName' found."
}