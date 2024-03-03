#!/bin/bash

# Print computer processes
echo "Current Processes:"
ps

# Prompt user to input the name of the program
read -p "Enter the name of the program you want to terminate: " programName

# Get all processes matching the input program name
matchingProcesses=$(ps aux | grep $programName)

if [[ $matchingProcesses ]]; then
    # Display process IDs to the user
    echo "Matching Processes:"
    echo "$matchingProcesses" | awk '{print $2, $11}'

    # Prompt user to select a process to terminate
    read -p "Enter the ID of the process you want to terminate: " selectedPID

    # Check if the entered PID is valid
    selectedProcess=$(echo "$matchingProcesses" | awk -v pid="$selectedPID" '$2 == pid {print $2}')

    if [[ $selectedProcess ]]; then
        # Terminate the selected process using kill
        kill -9 $selectedPID
        echo "Process with ID $selectedPID has been terminated."
    else
        echo "Invalid process ID. No process terminated."
    fi
else
    echo "No processes matching '$programName' found."
fi