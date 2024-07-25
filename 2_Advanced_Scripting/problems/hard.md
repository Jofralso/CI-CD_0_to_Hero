# Hard Problem: Automation Script with Functions and Error Handling

## Task

Create a Bash script that automates the backup of a directory. The script should:
- Accept the directory path and backup destination as arguments.
- Check if the directory exists.
- Create a compressed archive of the directory.
- Move the archive to the backup destination.
- Implement error handling for each step and log the operations to a file.

## Steps

1. Create a new file named `backup.sh`.
2. Write a script that:
   - Accepts the directory path and backup destination as command-line arguments.
   - Checks if the directory exists.
   - Creates a compressed archive of the directory using `tar`.
   - Moves the archive to the backup destination.
   - Implements error handling and logs operations to a file.
3. Make the script executable and run it with various test cases.

### Example

```bash
#!/bin/bash

LOGFILE="backup.log"

log() {
  echo "$(date): $1" >> $LOGFILE
}

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 source_directory backup_destination"
  log "Error: Missing arguments."
  exit 1
fi

SOURCE_DIR=$1
BACKUP_DEST=$2
ARCHIVE_NAME="$(basename $SOURCE_DIR)_$(date +%Y%m%d%H%M%S).tar.gz"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Source directory '$SOURCE_DIR' does not exist."
  log "Error: Source directory '$SOURCE_DIR' does not exist."
  exit 1
fi

log "Starting backup of directory '$SOURCE_DIR'."

tar -czf $ARCHIVE_NAME $SOURCE_DIR 2>> $LOGFILE
if [ $? -ne 0 ]; then
  echo "Error: Failed to create archive."
  log "Error: Failed to create archive."
  exit 1
fi

mv $ARCHIVE_NAME $BACKUP_DEST 2>> $LOGFILE
if [ $? -ne 0 ]; then
  echo "Error: Failed to move archive to backup destination."
  log "Error: Failed to move archive to backup destination."
  exit 1
fi

log "Backup of directory '$SOURCE_DIR' completed successfully."
echo "Backup completed successfully."
```