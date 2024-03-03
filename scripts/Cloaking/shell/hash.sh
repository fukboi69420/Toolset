#!/bin/bash

# Check if openssl is installed
if ! command -v openssl &> /dev/null; then
    echo "openssl could not be found"
    echo "Attempting to install openssl..."
    # Install openssl via APT package manager if it's not already installed
    sudo apt-get install openssl
fi

# Ask the user for the file path
read -p "Enter your file path: " file

# Check if the file exists
if [ -f "$file" ]; then
    # Ask the user for the hash algorithm
    read -p "Enter the hash algorithm (SHA1, SHA256, SHA384, SHA512, MD5) or type \"all\" to use all algorithms: " algorithm

    # Define the list of all algorithms
    allAlgorithms=("SHA1" "SHA256" "SHA384" "SHA512" "MD5")

    # Determine which algorithms to use
    if [ "$algorithm" == "all" ]; then
        algorithms=("${allAlgorithms[@]}")
    elif [[ " ${allAlgorithms[@]} " =~ " ${algorithm} " ]]; then
        algorithms=("$algorithm")
    else
        echo "Invalid algorithm. Please enter one of the following: SHA1, SHA256, SHA384, SHA512, MD5, or all."
        exit 1
    fi

    # Calculate and print the hash for each algorithm
    for alg in "${algorithms[@]}"; do
        # Calculate the hash
        hash=$(openssl dgst -$alg "$file" | awk '{print $NF}')
        if [ $? -eq 0 ]; then
            # Print the hash
            echo "The $alg hash of the file is: $hash"
        else
            echo "An error occurred: $_"
            exit 1
        fi
    done
else
    echo "The file does not exist."
fi