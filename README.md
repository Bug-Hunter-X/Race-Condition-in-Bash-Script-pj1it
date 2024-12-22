# Race Condition in Bash Script

This repository demonstrates a race condition in a simple bash script.  Two processes concurrently modify a shared file, resulting in an unexpected final value for the counter variable.

The `bug.sh` script showcases the race condition. The `bugSolution.sh` script demonstrates a solution using locking mechanisms to avoid the race condition.

## How to Reproduce

1. Clone this repository
2. Run `bash bug.sh`
3. Observe the output (the final counter value might not be as expected).
4. Run `bash bugSolution.sh`
5. Observe the output (the final counter value will be as expected.)