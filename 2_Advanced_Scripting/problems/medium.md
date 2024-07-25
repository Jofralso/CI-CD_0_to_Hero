 Medium Problem: Script with Variables and Control Structures

## Task

Create a Bash script that accepts a file name as an argument, checks if the file exists, and displays its contents. If the file does not exist, print an error message.

## Steps

1. Create a new file named `file_checker.sh`.
2. Write a script that:
   - Accepts a file name as a command-line argument.
   - Checks if the file exists.
   - If the file exists, prints its contents using the `cat` command.
   - If the file does not exist, prints an error message.
3. Make the script executable and run it with various test cases.

### Example

```bash
#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 filename"
  exit 1
fi

if [ -f "$1" ]; then
  cat "$1"
else
  echo "Error: File '$1' not found."
  exit 1
fi
```