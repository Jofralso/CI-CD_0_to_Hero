# Solutions for Advanced Scripting Problems

## Easy Problem Solution

### Script

```bash
#!/bin/bash

echo "Hello, World!"
echo "Current date and time: $(date)"
```

### Explanation

- The script prints "Hello, World!" using the `echo` command.
- It then prints the current date and time using the `date` command within a command substitution `$(...)`.

## Medium Problem Solution

### Script

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

### Explanation

- The script first checks if an argument (file name) is provided using `-z "$1"`.
- If not, it prints a usage message and exits with status 1.
- It then checks if the file exists using `[ -f "$1" ]`.
- If the file exists, it prints the file contents using `cat`.
- If the file does not exist, it prints an error message and exits with status 1.

## Hard Problem Solution

### Script

```bash
#!/bin/bash

LOGFILE="backup.log"

log() {
  echo "$(date): $1" >> $LOGFILE
}

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 source_directory backup

_destination"
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

### Explanation

- The script logs messages to `backup.log` using the `log` function.
- It checks if the source directory and backup destination are provided as arguments.
- If not, it logs and prints an error message and exits.
- It verifies if the source directory exists and logs/prints an error if not.
- It creates a compressed archive of the source directory using `tar` and logs/prints an error if the operation fails.
- It moves the archive to the backup destination and logs/prints an error if the operation fails.
- It logs and prints a success message upon successful completion of the backup.
