# Advanced Scripting Skills - Custom Automation Tools

## Overview

Developing custom scripts or tools to automate repetitive tasks can greatly enhance productivity. By creating automation tools tailored to specific needs, you can streamline workflows, reduce human error, and save time.

## Detailed Explanation

### Basic Concepts

- **Scripting Languages**: Use languages like Bash, Python, or PowerShell to write automation scripts.
- **Task Automation**: Automate routine tasks such as file manipulation, system monitoring, and data processing.
- **Configuration Management**: Use tools like Ansible or Chef to automate system configurations.
- **Scheduling**: Automate task execution using cron jobs (Unix) or Task Scheduler (Windows).

### Advanced Concepts

- **APIs and Webhooks**: Integrate scripts with other applications and services using APIs and webhooks.
- **Parallel Processing**: Enhance performance by running tasks in parallel using multiprocessing libraries in Python.
- **Error Handling and Logging**: Implement robust error handling and logging mechanisms to ensure reliability and traceability.
- **User Interfaces**: Create simple GUIs or command-line interfaces for your tools to enhance usability.
- **Version Control**: Manage and track changes to your scripts using Git or other version control systems.

## Resources

- [Automate the Boring Stuff with Python](https://automatetheboringstuff.com/)
- [Linux Shell Scripting Tutorial](https://bash.cyberciti.biz/guide/Main_Page)
- [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/)
- [Python Multiprocessing Documentation](https://docs.python.org/3/library/multiprocessing.html)

## Exercises

### Easy Problem

**Task**: Write a Python script to rename all files in a directory to lowercase.

**Solution**:
```python
import os

directory = '/path/to/directory'

for filename in os.listdir(directory):
    lowercase_filename = filename.lower()
    os.rename(os.path.join(directory, filename), os.path.join(directory, lowercase_filename))

print("All files renamed to lowercase.")
```

### Medium Problem

**Task**: Write a Bash script to monitor disk usage and send an email alert if usage exceeds a specified threshold.

**Solution**:
```bash
#!/bin/bash

THRESHOLD=80
EMAIL="admin@example.com"
PARTITION="/"

usage=$(df -h | grep $PARTITION | awk '{print $5}' | sed 's/%//g')

if [ $usage -ge $THRESHOLD ]; then
  echo "Disk usage for $PARTITION is at ${usage}%." | mail -s "Disk Usage Alert" $EMAIL
fi
```

### Hard Problem

**Task**: Write a Python script to periodically back up a directory to a remote server using SCP, with error handling and logging.

**Solution**:
```python
import os
import time
import logging
from paramiko import SSHClient, AutoAddPolicy
from scp import SCPClient

logging.basicConfig(filename='backup.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def create_ssh_client(server, port, user, password):
    client = SSHClient()
    client.load_system_host_keys()
    client.set_missing_host_key_policy(AutoAddPolicy())
    client.connect(server, port, user, password)
    return client

def backup_directory(local_dir, remote_dir, server, port, user, password):
    try:
        ssh = create_ssh_client(server, port, user, password)
        scp = SCPClient(ssh.get_transport())
        scp.put(local_dir, recursive=True, remote_path=remote_dir)
        scp.close()
        logging.info(f"Backup of {local_dir} to {remote_dir} on {server} successful.")
    except Exception as e:
        logging.error(f"Error during backup: {e}")

if __name__ == "__main__":
    local_directory = "/path/to/local_directory"
    remote_directory = "/path/to/remote_directory"
    server = "remote.server.com"
    port = 22
    user = "username"
    password = "password"
    
    while True:
        backup_directory(local_directory, remote_directory, server, port, user, password)
        time.sleep(86400)  # Run every 24 hours
```

## Cheat Sheet

### Bash

- **Basic Commands**: `echo`, `ls`, `cp`, `mv`, `rm`
- **Variables**: `variable_name=value`
- **Loops**: 
  ```bash
  for i in {1..5}; do
    echo "Loop $i"
  done
  ```
- **Conditionals**:
  ```bash
  if [ condition ]; then
    # code
  fi
  ```
- **Cron Jobs**: 
  ```bash
  # Edit cron jobs
  crontab -e
  
  # Run a script every day at 2 AM
  0 2 * * * /path/to/script.sh
  ```

### Python

- **Basic Commands**: `print()`, `os.listdir()`, `os.rename()`
- **Functions**:
  ```python
  def function_name(parameters):
      # code
  ```
- **Loops**:
  ```python
  for i in range(5):
      print(f"Loop {i}")
  ```
- **Conditionals**:
  ```python
  if condition:
      # code
  ```
- **Logging**:
  ```python
  import logging
  logging.basicConfig(filename='app.log', level=logging.INFO)
  logging.info('This is an info message')
  ```

### Version Control

- **Initialize Repository**:
  ```bash
  git init
  ```
- **Add Changes**:
  ```bash
  git add filename
  ```
- **Commit Changes**:
  ```bash
  git commit -m "commit message"
  ```
- **Push to Remote**:
  ```bash
  git push origin branch_name
  ```
