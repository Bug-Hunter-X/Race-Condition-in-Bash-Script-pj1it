#!/bin/bash

# This script demonstrates a race condition.
# It uses two processes to modify a shared file concurrently.

# Create a shared file
echo 0 > shared.txt

# Function to increment the counter in shared.txt
increment_counter() {
  local counter=$(cat shared.txt)
  local new_counter=$((counter + 1))
  echo $new_counter > shared.txt
}

# Function to decrement the counter in shared.txt
decrement_counter() {
  local counter=$(cat shared.txt)
  local new_counter=$((counter - 1))
  echo $new_counter > shared.txt
}

# Run the functions concurrently
increment_counter &
decrement_counter &
wait  # Wait for both background processes to finish

# Print the final result
cat shared.txt