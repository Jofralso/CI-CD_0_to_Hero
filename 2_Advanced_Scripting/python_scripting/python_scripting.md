# Advanced Scripting Skills - Python

## Overview

Python is widely used for automation due to its simplicity and powerful libraries. Its clean syntax and extensive standard library make it an excellent choice for developing scripts and automation tools for a variety of tasks.

## Detailed Explanation

### Basic Concepts

- **Syntax and Variables**: Python uses indentation to define code blocks. Variables are dynamically typed. Example:
  ```python
  variable_name = "value"
  ```
- **Control Structures**: Includes conditionals (`if`, `elif`, `else`) and loops (`for`, `while`).
- **Functions**: Defined using the `def` keyword and can accept parameters and return values. Example:
  ```python
  def function_name(param1, param2):
      # code
      return result
  ```

### Advanced Concepts

- **List Comprehensions**: Provide a concise way to create lists. Example:
  ```python
  squares = [x**2 for x in range(10)]
  ```
- **Decorators**: Functions that modify the behavior of other functions. Example:
  ```python
  def my_decorator(func):
      def wrapper():
          print("Something is happening before the function is called.")
          func()
          print("Something is happening after the function is called.")
      return wrapper

  @my_decorator
  def say_hello():
      print("Hello!")
  ```
- **Generators**: Use `yield` to create iterators. Example:
  ```python
  def count_up_to(max):
      count = 1
      while count <= max:
          yield count
          count += 1
  ```
- **Error Handling**: Use `try`, `except`, and `finally` to manage exceptions. Example:
  ```python
  try:
      # code that may raise an exception
  except SomeException as e:
      # code to handle the exception
  finally:
      # code to execute regardless of whether an exception occurred
  ```
- **Libraries**: Utilize libraries like `requests` for HTTP requests, `pandas` for data manipulation, and `subprocess` for system commands.

## Resources

- [Python Official Documentation](https://docs.python.org/3/)
- [Automate the Boring Stuff with Python](https://automatetheboringstuff.com/)
- [Real Python Tutorials](https://realpython.com/)

## Exercises

### Easy Problem

**Task**: Write a Python script to read a text file and print its contents.

**Solution**:
```python
# Read and print file contents

file_path = 'example.txt'

with open(file_path, 'r') as file:
    content = file.read()

print(content)
```

### Medium Problem

**Task**: Write a Python script to fetch data from a public API and save it to a JSON file.

**Solution**:
```python
import requests
import json

url = 'https://api.example.com/data'
response = requests.get(url)

if response.status_code == 200:
    data = response.json()
    with open('data.json', 'w') as json_file:
        json.dump(data, json_file, indent=4)
    print("Data successfully written to data.json")
else:
    print("Failed to retrieve data:", response.status_code)
```

### Hard Problem

**Task**: Write a Python script to monitor a directory for new files and process them using a custom function.

**Solution**:
```python
import os
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

class DirectoryMonitor(FileSystemEventHandler):
    def on_created(self, event):
        if not event.is_directory:
            process_file(event.src_path)

def process_file(file_path):
    print(f"Processing file: {file_path}")
    # Add file processing logic here

if __name__ == "__main__":
    path = "/path/to/directory"
    event_handler = DirectoryMonitor()
    observer = Observer()
    observer.schedule(event_handler, path=path, recursive=False)
    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
```

## Cheat Sheet

### Basic Commands

- **Print**:
  ```python
  print("Hello, World!")
  ```
- **Read File**:
  ```python
  with open('file.txt', 'r') as file:
      content = file.read()
  ```

### Control Structures

- **If-Else**:
  ```python
  if condition:
      # code
  elif other_condition:
      # code
  else:
      # code
  ```

- **For Loop**:
  ```python
  for item in iterable:
      # code
  ```

- **While Loop**:
  ```python
  while condition:
      # code
  ```

### Functions

- **Define Function**:
  ```python
  def function_name(parameters):
      # code
      return result
  ```

### Advanced Concepts

- **List Comprehensions**:
  ```python
  [expression for item in iterable]
  ```

- **Decorators**:
  ```python
  @decorator_function
  def function():
      # code
  ```

- **Generators**:
  ```python
  def generator_function():
      yield value
  ```

- **Error Handling**:
  ```python
  try:
      # code
  except Exception as e:
      # handle exception
  finally:
      # cleanup
  ```