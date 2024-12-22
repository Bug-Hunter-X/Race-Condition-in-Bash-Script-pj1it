#!/bin/bash

# This script demonstrates a solution to the race condition using flock.
# It uses two processes to modify a shared file concurrently, but with locking to prevent race conditions.

# Create a shared file
echo 0 > shared.txt

# Function to increment the counter in shared.txt
increment_counter() {
  flock -n 200 || exit 1 # acquire an exclusive lock on file descriptor 200 (shared.txt)
  local counter=$(cat shared.txt)
  local new_counter=$((counter + 1))
  echo $new_counter > shared.txt
  flock -u 200 #unlock file descriptor 200 
}

# Function to decrement the counter in shared.txt
decrement_counter() {
  flock -n 200 || exit 1 # acquire an exclusive lock on file descriptor 200 (shared.txt)
  local counter=$(cat shared.txt)
  local new_counter=$((counter - 1))
  echo $new_counter > shared.txt
  flock -u 200 #unlock file descriptor 200
}

# Run the functions concurrently.  Note that using exec will replace the current shell process which is better than a background process.
exec increment_counter
exec decrement_counter

# Print the final result - this will never run because exec replaces the current shell process.
# cat shared.txt